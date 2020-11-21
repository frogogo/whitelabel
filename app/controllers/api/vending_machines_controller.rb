class API::VendingMachinesController < APIController
  def assign
    @user = current_user
    @receipt = @user.receipts.approved.find_by(id: params[:receipt_id])
    @vending_machine =
      VendingMachine.includes(vending_cells: :item)
                    .find_by(public_id: params[:id])

    return head :not_found if @vending_machine.blank? || @receipt.blank?
    return head :unprocessable_entity if !@vending_machine.busy? && @user.busy?
    return head :unprocessable_entity if @vending_machine.busy? && !assigned_to_each_other?

    assign_to_each_other unless assigned_to_each_other?
  end

  def take_item
    @user = current_user
    @item = Item.active.find_by(id: params[:item_id])
    @receipt = @user.receipts.approved.find_by(id: params[:receipt_id])
    @vending_machine = VendingMachine.find_by(public_id: params[:id])

    return head :not_found if @vending_machine.blank? || @item.blank? || @receipt.blank?
    return head :unprocessable_entity unless assigned_to_each_other?

    if @vending_machine.take_item(@item, @receipt, params[:vending_cell_id])
      head :ok
    else
      head :unprocessable_entity
    end
  end

  private

  def assign_to_each_other
    @vending_machine.assign(@user)
    @user.assign(@vending_machine)
  end

  def assigned_to_each_other?
    @vending_machine.assigned?(@user) && @user.assigned?(@vending_machine)
  end
end
