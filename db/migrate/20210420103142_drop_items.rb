class DropItems < ActiveRecord::Migration[6.1]
  def up
    drop_table :items
  end

  def down
    create_table "items", force: :cascade do |t|
      t.bigint "manufacturer_id"
      t.bigint "promotion_id"
      t.string "name", null: false
      t.string "bar_code", null: false
      t.string "size", null: false
      t.datetime "created_at", precision: 6, null: false
      t.datetime "updated_at", precision: 6, null: false
      t.integer "quantity"
      t.integer "start_quantity"
      t.boolean "active", default: false
      t.string "image"
      t.index ["manufacturer_id"], name: "index_items_on_manufacturer_id"
      t.index ["promotion_id"], name: "index_items_on_promotion_id"
    end

    add_foreign_key "items", "manufacturers"
    add_foreign_key "items", "promotions"
  end
end
