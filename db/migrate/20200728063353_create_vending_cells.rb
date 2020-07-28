class CreateVendingCells < ActiveRecord::Migration[6.0]
  def change
    create_table :vending_cells do |t|
      t.belongs_to :vending_machine, foreign_key: true

      t.integer :column, null: false
      t.integer :row, null: false
      t.integer :quantity, null: false, default: 0

      t.timestamps
    end
  end
end
