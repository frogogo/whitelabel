class CreateVendingMachines < ActiveRecord::Migration[6.0]
  def change
    create_table :vending_machines do |t|
      t.belongs_to :distribution_network, foreign_key: true

      t.string :address, null: false

      t.boolean :active, null: false, default: false
      t.integer :public_id, null: false, index: { unique: true }

      t.integer :vending_cells_columns, null: false
      t.integer :vending_cells_rows, null: false

      t.timestamps
    end
  end
end
