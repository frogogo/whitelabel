# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2021_04_20_105642) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "pgcrypto"
  enable_extension "plpgsql"

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

  create_table "promotions", force: :cascade do |t|
    t.string "api_token", null: false
    t.string "name", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "description"
    t.integer "promo_id", null: false
    t.boolean "active", default: false
  end

  create_table "receipts", force: :cascade do |t|
    t.string "qr_string", null: false
    t.integer "state", default: 0, null: false
    t.integer "reject_reason"
    t.bigint "promotion_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.uuid "uuid"
    t.jsonb "data", default: {}, null: false
    t.bigint "user_id", null: false
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
    t.uuid "uuid", default: -> { "gen_random_uuid()" }, null: false
    t.index ["phone_number"], name: "index_users_on_phone_number", unique: true
    t.index ["refresh_token"], name: "index_users_on_refresh_token", unique: true
  end

  add_foreign_key "receipts", "promotions"
  add_foreign_key "receipts", "users"
end
