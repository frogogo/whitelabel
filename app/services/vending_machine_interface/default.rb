# frozen_string_literal: true

class VendingMachineInterface::Default
  def initialize(vending_machine, receipt: nil, user: nil, options: nil)
    @vending_machine = vending_machine
    @item = options&.fetch(:item)
    @receipt = receipt
    @user = user
    @options = options
  end

  def assign
    raise NotImplementedError
  end

  def take_item
    raise NotImplementedError
  end

  private

  attr_reader :vending_machine, :item, :receipt, :user, :options

  def take_item_from_cell
    return unless vending_cell.active?

    vending_cell.take_item
  end

  def update_receipt
    receipt.item = item
    receipt.state = :completed
    receipt.save
  end

  def vending_cell
    @vending_cell ||= vending_machine.vending_cells.find_by!(options)
  end
end
