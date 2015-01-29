# encoding: UTF-8
# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 20141112071908) do

  create_table "bank_details", force: true do |t|
    t.string   "bsb"
    t.string   "account_number"
    t.string   "account_name"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "{:index=>true}_id"
  end

  create_table "billers", force: true do |t|
    t.string   "name"
    t.string   "address1"
    t.string   "address2"
    t.string   "town"
    t.string   "postcode"
    t.string   "email"
    t.string   "phone"
    t.string   "image"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "{:index=>true}_id"
  end

  create_table "debtors", force: true do |t|
    t.string   "name"
    t.string   "address1"
    t.string   "address2"
    t.string   "town"
    t.string   "postcode"
    t.string   "email"
    t.string   "phone"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "{:index=>true}_id"
  end

  create_table "freight_codes", force: true do |t|
    t.string  "name"
    t.integer "{:index=>true}_id"
    t.float   "rate"
  end

  create_table "invoices", force: true do |t|
    t.string   "date"
    t.string   "invoice_number"
    t.integer  "amount"
    t.integer  "billers_id"
    t.integer  "debtors_id"
    t.integer  "items_id"
    t.integer  "tax_codes_id"
    t.integer  "freight_codes_id"
    t.integer  "bank_details_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "qty"
  end

  add_index "invoices", ["bank_details_id"], name: "index_invoices_on_bank_details_id"
  add_index "invoices", ["billers_id"], name: "index_invoices_on_billers_id"
  add_index "invoices", ["debtors_id"], name: "index_invoices_on_debtors_id"
  add_index "invoices", ["freight_codes_id"], name: "index_invoices_on_freight_codes_id"
  add_index "invoices", ["items_id"], name: "index_invoices_on_items_id"
  add_index "invoices", ["tax_codes_id"], name: "index_invoices_on_tax_codes_id"

  create_table "items", force: true do |t|
    t.string   "name"
    t.string   "description"
    t.integer  "tax_code"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "{:index=>true}_id"
    t.float    "price"
  end

  create_table "tax_codes", force: true do |t|
    t.string  "name"
    t.integer "percent"
    t.integer "{:index=>true}_id"
  end

end
