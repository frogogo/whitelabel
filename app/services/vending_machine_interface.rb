# frozen_string_literal: true

module VendingMachineInterface
  def self.assign(vending_machine, user)
    case vending_machine.vm_type
    when 'virtual'
      VendingMachineInterface::Virtual.new(vending_machine, user: user).assign
    end
  end

  def self.take_item(vending_machine, receipt, options)
    case vending_machine.vm_type
    when 'virtual'
      VendingMachineInterface::Virtual.new(
        vending_machine, receipt: receipt, options: options
      ).take_item
    end
  end
end
