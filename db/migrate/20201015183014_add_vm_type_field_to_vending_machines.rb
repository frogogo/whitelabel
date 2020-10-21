class AddVmTypeFieldToVendingMachines < ActiveRecord::Migration[6.0]
  def change
    add_column :vending_machines, :vm_type, :integer, default: 0, null: false
  end
end
