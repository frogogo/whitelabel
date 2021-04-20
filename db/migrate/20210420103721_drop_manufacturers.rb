class DropManufacturers < ActiveRecord::Migration[6.1]
  def up
    drop_table :manufacturers
  end

  def down
    create_table "manufacturers", force: :cascade do |t|
      t.string "name", null: false
      t.string "account"
      t.string "business_address"
      t.string "chief_executive_officer"
      t.string "constact_person"
      t.string "taxpayer_identification_number"
      t.string "tax_registration_reason_code"
      t.string "email"
      t.string "phone_number"
      t.datetime "created_at", precision: 6, null: false
      t.datetime "updated_at", precision: 6, null: false
      t.index ["name"], name: "index_manufacturers_on_name", unique: true
    end
  end
end
