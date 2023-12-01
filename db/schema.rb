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

ActiveRecord::Schema.define(version: 2021_08_03_141505) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "billings", force: :cascade do |t|
    t.text "email"
    t.integer "amount"
    t.json "balance", default: {}
    t.float "without_tax"
    t.float "tax_price"
    t.float "total_bill"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "denominations", force: :cascade do |t|
    t.integer "rupees"
    t.integer "count"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "product_details", force: :cascade do |t|
    t.integer "quantity"
    t.float "purchased_price"
    t.float "tax_payable_for_item"
    t.float "total_price_of_item"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.bigint "billing_id", null: false
    t.bigint "product_id", null: false
    t.index ["billing_id"], name: "index_product_details_on_billing_id"
    t.index ["product_id"], name: "index_product_details_on_product_id"
  end

  create_table "products", force: :cascade do |t|
    t.string "name"
    t.float "unit_price"
    t.float "tax_percentage"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  add_foreign_key "product_details", "billings"
  add_foreign_key "product_details", "products"
end
