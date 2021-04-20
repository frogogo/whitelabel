class DropVendingCells < ActiveRecord::Migration[6.1]
  def up
    drop_table :vending_cells
  end

  def down
    create_table "vending_cells", force: :cascade do |t|
      t.bigint "vending_machine_id"
      t.integer "column", null: false
      t.integer "row", null: false
      t.integer "quantity", default: 0, null: false
      t.datetime "created_at", precision: 6, null: false
      t.datetime "updated_at", precision: 6, null: false
      t.bigint "item_id"
      t.index ["item_id"], name: "index_vending_cells_on_item_id"
      t.index ["vending_machine_id"], name: "index_vending_cells_on_vending_machine_id"
    end
    add_foreign_key "vending_cells", "items"
    add_foreign_key "vending_cells", "vending_machines"
  end
end
