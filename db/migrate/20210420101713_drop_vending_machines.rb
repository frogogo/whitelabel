class DropVendingMachines < ActiveRecord::Migration[6.1]
  def up
    drop_table :vending_machines
  end

  def down
    create_table "vending_machines", force: :cascade do |t|
      t.bigint "distribution_network_id"
      t.string "address", null: false
      t.boolean "active", default: false, null: false
      t.integer "public_id", null: false
      t.integer "vending_cells_columns", null: false
      t.integer "vending_cells_rows", null: false
      t.datetime "created_at", precision: 6, null: false
      t.datetime "updated_at", precision: 6, null: false
      t.integer "vm_type", default: 0, null: false
      t.index ["distribution_network_id"], name: "index_vending_machines_on_distribution_network_id"
      t.index ["public_id"], name: "index_vending_machines_on_public_id", unique: true
    end

    add_foreign_key "vending_machines", "distribution_networks"
  end
end
