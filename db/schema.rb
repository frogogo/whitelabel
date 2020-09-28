# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `rails
# db:schema:load`. When creating a new database, `rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2020_09_28_080105) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "active_storage_attachments", force: :cascade do |t|
    t.string "name", null: false
    t.string "record_type", null: false
    t.bigint "record_id", null: false
    t.bigint "blob_id", null: false
    t.datetime "created_at", null: false
    t.index ["blob_id"], name: "index_active_storage_attachments_on_blob_id"
    t.index ["record_type", "record_id", "name", "blob_id"], name: "index_active_storage_attachments_uniqueness", unique: true
  end

  create_table "active_storage_blobs", force: :cascade do |t|
    t.string "key", null: false
    t.string "filename", null: false
    t.string "content_type"
    t.text "metadata"
    t.bigint "byte_size", null: false
    t.string "checksum", null: false
    t.datetime "created_at", null: false
    t.index ["key"], name: "index_active_storage_blobs_on_key", unique: true
  end

  create_table "administrators", force: :cascade do |t|
    t.string "email"
    t.string "password_digest"
    t.string "first_name"
    t.string "last_name"
    t.string "remember_token"
    t.datetime "remember_token_expires_at"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "distribution_networks", force: :cascade do |t|
    t.string "name", null: false
    t.string "account"
    t.string "business_address"
    t.string "chief_executive_officer"
    t.string "constact_person"
    t.string "taxpayer_identification_number"
    t.string "tax_registration_reason_code"
    t.string "email"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["name"], name: "index_distribution_networks_on_name", unique: true
  end

  create_table "items", force: :cascade do |t|
    t.bigint "manufacturer_id"
    t.bigint "promotion_id"
    t.string "name", null: false
    t.string "bar_code", null: false
    t.string "size", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["manufacturer_id"], name: "index_items_on_manufacturer_id"
    t.index ["promotion_id"], name: "index_items_on_promotion_id"
  end

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

  create_table "promotions", force: :cascade do |t|
    t.string "api_token", null: false
    t.string "name", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "description"
    t.integer "promo_id", null: false
    t.bigint "distribution_network_id", null: false
    t.index ["distribution_network_id"], name: "index_promotions_on_distribution_network_id"
  end

  create_table "receipts", force: :cascade do |t|
    t.string "qr_string", null: false
    t.integer "state", default: 0, null: false
    t.integer "reject_reason"
    t.bigint "promotion_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.uuid "uuid"
    t.jsonb "data", null: false
    t.bigint "user_id", null: false
    t.bigint "item_id"
    t.index ["item_id"], name: "index_receipts_on_item_id"
    t.index ["promotion_id"], name: "index_receipts_on_promotion_id"
    t.index ["qr_string"], name: "index_receipts_on_qr_string", unique: true
    t.index ["user_id"], name: "index_receipts_on_user_id"
    t.index ["uuid"], name: "index_receipts_on_uuid", unique: true
  end

  create_table "users", force: :cascade do |t|
    t.string "phone_number", null: false
    t.string "first_name"
    t.string "email"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "refresh_token", null: false
    t.integer "role", default: 0, null: false
    t.index ["phone_number"], name: "index_users_on_phone_number", unique: true
    t.index ["refresh_token"], name: "index_users_on_refresh_token", unique: true
  end

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

  create_table "vending_machines", force: :cascade do |t|
    t.bigint "distribution_network_id"
    t.string "address", null: false
    t.boolean "active", default: false, null: false
    t.integer "public_id", null: false
    t.integer "vending_cells_columns", null: false
    t.integer "vending_cells_rows", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["distribution_network_id"], name: "index_vending_machines_on_distribution_network_id"
    t.index ["public_id"], name: "index_vending_machines_on_public_id", unique: true
  end

  add_foreign_key "active_storage_attachments", "active_storage_blobs", column: "blob_id"
  add_foreign_key "items", "manufacturers"
  add_foreign_key "items", "promotions"
  add_foreign_key "promotions", "distribution_networks"
  add_foreign_key "receipts", "items"
  add_foreign_key "receipts", "promotions"
  add_foreign_key "receipts", "users"
  add_foreign_key "vending_cells", "items"
  add_foreign_key "vending_cells", "vending_machines"
  add_foreign_key "vending_machines", "distribution_networks"
end
