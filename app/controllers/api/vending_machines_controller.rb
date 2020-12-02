class API::VendingMachinesController < APIController
  def assign
    @user = current_user
    @receipt = @user.receipts.approved.find_by(id: params[:receipt_id])
    @vending_machine =
      VendingMachine.includes(vending_cells: :item)
                    .find_by(public_id: params[:id])

    return head :not_found if @vending_machine.blank? || @receipt.blank?
    return render_user_busy_error if !@vending_machine.busy? && @user.busy?
    return render_busy_error if @vending_machine.busy? && !@user.busy?

    if @vending_machine.busy? && @user.busy? && !@vending_machine.assigned?(@user)
      if @vending_machine.assign_expires_at > @user.assign_time_limit_expires_at
        return render_busy_error
      else
        return render_user_busy_error
      end
    end

    @vending_machine.assign(@user) unless @vending_machine.assigned?(@user)
  end

  def take_item
    @user = current_user
    @item = Item.active.find_by(id: params[:item_id])
    @receipt = @user.receipts.approved.find_by(id: params[:receipt_id])
    @vending_machine = VendingMachine.find_by(public_id: params[:id])

    return head :not_found if @vending_machine.blank? || @item.blank? || @receipt.blank?
    return render_error(:not_assigned) unless @vending_machine.assigned?(@user)

    result = @vending_machine.take_item(@item, @receipt, params[:vending_cell_id])
    if result == :ok
      @vending_machine.unassign(@user)
      head :ok
    else
      render_error(result)
    end
  rescue StandardError => e
    render_error(:something_went_wrong)

    Rails.logger.error(e)
    Rollbar.error("Vending machine #{@vending_machine.public_id} update failed. Item not taken: #{e}")
  end

  private

  def render_busy_error
    render_error(
      :busy,
      options: { time_left: time_left_for(@vending_machine.assign_expires_at) }
    )
  end

  def render_user_busy_error
    render_error(
      :user_busy,
      options: { time_left: time_left_for(@user.assign_time_limit_expires_at) }
    )
  end
end
