class API::VendingMachinesController < APIController
  def show
    @vending_machine =
      VendingMachine.includes(vending_cells: { item: { image_attachment: :blob } })
                    .find_by(public_id: params[:id])
    @user = current_user

    return head :not_found if @vending_machine.blank?
    if @vending_machine.busy? && !@vending_machine.assigned?(@user)
      return head :unprocessable_entity
    end

    @vending_machine.assign(@user) unless @vending_machine.assigned?(@user)
  end
end
