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

ActiveRecord::Schema.define(version: 20171214004418) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "authentications", force: :cascade do |t|
    t.integer "person_id", null: false
    t.string "provider", null: false
    t.string "uid", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["provider", "uid"], name: "ind_authentications_provider_uid"
  end

  create_table "people", force: :cascade do |t|
    t.text "username", null: false
    t.text "username_canonical", null: false
    t.text "email"
    t.text "name"
    t.text "picture_id"
    t.integer "product_id", null: false
    t.text "crypted_password"
    t.text "salt"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "remember_me_token"
    t.datetime "remember_me_token_expires_at"
    t.text "facebookid"
    t.index ["product_id", "email"], name: "unq_people_product_email", unique: true
    t.index ["product_id", "facebookid"], name: "unq_people_product_facebook", unique: true
    t.index ["product_id", "username_canonical"], name: "unq_people_product_username_canonical", unique: true
    t.index ["remember_me_token"], name: "ind_people_remember_me_token"
  end

  create_table "products", force: :cascade do |t|
    t.text "name", null: false
    t.text "internal_name", null: false
    t.boolean "enabled", default: false, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["internal_name"], name: "unq_products_internal_name", unique: true
    t.index ["name"], name: "unq_products_name", unique: true
  end

  create_table "versions", force: :cascade do |t|
    t.text "item_type", null: false
    t.integer "item_id", null: false
    t.text "event", null: false
    t.text "whodunnit"
    t.text "object"
    t.datetime "created_at"
    t.index ["item_type", "item_id"], name: "ind_versions_item_type_item_id"
  end

  add_foreign_key "authentications", "people", name: "fk_authentications_people"
  add_foreign_key "people", "products", name: "fk_people_products", on_delete: :cascade
end
