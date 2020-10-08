class AddQuantityFieldsToItems < ActiveRecord::Migration[6.0]
  def change
    add_column :items, :quantity, :integer, null: true
    add_column :items, :start_quantity, :integer, null: true
  end
end
