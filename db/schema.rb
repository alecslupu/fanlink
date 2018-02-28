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

ActiveRecord::Schema.define(version: 20180227010351) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "action_types", force: :cascade do |t|
    t.text "name", null: false
    t.text "internal_name", null: false
    t.integer "seconds_lag", default: 0, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.boolean "active", default: true, null: false
  end

  create_table "authentications", force: :cascade do |t|
    t.integer "person_id", null: false
    t.string "provider", null: false
    t.string "uid", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["provider", "uid"], name: "ind_authentications_provider_uid"
  end

  create_table "badge_actions", force: :cascade do |t|
    t.integer "action_type_id", null: false
    t.integer "person_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.text "identifier"
    t.index ["action_type_id", "person_id"], name: "ind_badge_actions_action_type_person"
    t.index ["person_id", "action_type_id", "identifier"], name: "unq_badge_action_person_action_type_identifier", unique: true, where: "(identifier IS NOT NULL)"
  end

  create_table "badge_awards", force: :cascade do |t|
    t.integer "person_id", null: false
    t.integer "badge_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["person_id", "badge_id"], name: "unq_badge_awards_people_badges", unique: true
  end

  create_table "badges", force: :cascade do |t|
    t.integer "product_id", null: false
    t.text "name", null: false
    t.text "internal_name", null: false
    t.integer "action_type_id", null: false
    t.integer "action_requirement", default: 1, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "point_value", default: 0, null: false
    t.string "picture_file_name"
    t.string "picture_content_type"
    t.integer "picture_file_size"
    t.datetime "picture_updated_at"
    t.text "description"
  end

  create_table "blocks", force: :cascade do |t|
    t.integer "blocker_id", null: false
    t.integer "blocked_id", null: false
    t.datetime "created_at", null: false
    t.index ["blocker_id", "blocked_id"], name: "unq_blocks_blocker_blocked", unique: true
    t.index ["blocker_id"], name: "ind_blocks_blocker"
  end

  create_table "followings", force: :cascade do |t|
    t.integer "follower_id", null: false
    t.integer "followed_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["followed_id"], name: "idx_followings_followed"
    t.index ["follower_id", "followed_id"], name: "unq_followings_follower_followed", unique: true
  end

  create_table "levels", force: :cascade do |t|
    t.integer "product_id", null: false
    t.text "name", null: false
    t.text "internal_name", null: false
    t.integer "points", default: 1000, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "picture_file_name"
    t.string "picture_content_type"
    t.integer "picture_file_size"
    t.datetime "picture_updated_at"
    t.index ["product_id", "internal_name"], name: "unq_levels_product_internal_name"
    t.index ["product_id", "points"], name: "unq_levels_product_points"
  end

  create_table "message_reports", force: :cascade do |t|
    t.integer "message_id", null: false
    t.integer "person_id", null: false
    t.text "reason"
    t.integer "status", default: 0, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "messages", force: :cascade do |t|
    t.integer "person_id", null: false
    t.integer "room_id", null: false
    t.text "body"
    t.boolean "hidden", default: false, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "status", default: 0, null: false
    t.string "picture_file_name"
    t.string "picture_content_type"
    t.integer "picture_file_size"
    t.datetime "picture_updated_at"
    t.index ["room_id"], name: "idx_messages_room"
  end

  create_table "notification_device_ids", force: :cascade do |t|
    t.integer "person_id", null: false
    t.text "device_identifier", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["device_identifier"], name: "unq_notification_device_ids_device", unique: true
    t.index ["person_id"], name: "idx_notification_device_ids_person"
  end

  create_table "people", force: :cascade do |t|
    t.text "username", null: false
    t.text "username_canonical", null: false
    t.text "email"
    t.text "name"
    t.integer "product_id", null: false
    t.text "crypted_password"
    t.text "salt"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.text "facebookid"
    t.text "facebook_picture_url"
    t.text "picture_type"
    t.string "picture_file_name"
    t.string "picture_content_type"
    t.integer "picture_file_size"
    t.datetime "picture_updated_at"
    t.boolean "do_not_message_me", default: false, null: false
    t.boolean "pin_messages_from", default: false, null: false
    t.boolean "auto_follow", default: false, null: false
    t.integer "role", default: 0, null: false
    t.text "reset_password_token"
    t.datetime "reset_password_token_expires_at"
    t.datetime "reset_password_email_sent_at"
    t.boolean "product_account", default: false, null: false
    t.index ["product_id", "auto_follow"], name: "idx_people_product_auto_follow"
    t.index ["product_id", "email"], name: "unq_people_product_email", unique: true
    t.index ["product_id", "facebookid"], name: "unq_people_product_facebook", unique: true
    t.index ["product_id", "username_canonical"], name: "unq_people_product_username_canonical", unique: true
  end

  create_table "post_reactions", force: :cascade do |t|
    t.integer "post_id", null: false
    t.integer "person_id", null: false
    t.text "reaction", null: false
    t.index ["post_id", "person_id"], name: "unq_post_reactions_post_person", unique: true
    t.index ["post_id"], name: "idx_post_reactions_post"
  end

  create_table "post_reports", force: :cascade do |t|
    t.integer "post_id", null: false
    t.integer "person_id", null: false
    t.text "reason"
    t.integer "status", default: 0, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["post_id"], name: "idx_post_reports_post"
  end

  create_table "posts", force: :cascade do |t|
    t.integer "person_id", null: false
    t.text "body_text_old"
    t.boolean "global", default: false, null: false
    t.datetime "starts_at"
    t.datetime "ends_at"
    t.integer "repost_interval", default: 0, null: false
    t.integer "status", default: 0, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "picture_file_name"
    t.string "picture_content_type"
    t.integer "picture_file_size"
    t.datetime "picture_updated_at"
    t.jsonb "body"
    t.index ["person_id"], name: "idx_posts_person"
  end

  create_table "products", force: :cascade do |t|
    t.text "name", null: false
    t.text "internal_name", null: false
    t.boolean "enabled", default: false, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.boolean "can_have_supers", default: false, null: false
    t.index ["internal_name"], name: "unq_products_internal_name", unique: true
    t.index ["name"], name: "unq_products_name", unique: true
  end

  create_table "relationships", force: :cascade do |t|
    t.integer "requested_by_id", null: false
    t.integer "requested_to_id", null: false
    t.integer "status", default: 0, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["requested_by_id", "requested_to_id"], name: "unq_relationships_requested_by_requested_to", unique: true
    t.index ["requested_by_id"], name: "idx_relationships_requested_by_id"
    t.index ["requested_to_id"], name: "idx_relationships_requested_to_id"
  end

  add_check "relationships", "(requested_by_id <> requested_to_id)", name: "chk_relationships_not_with_self"

  create_table "room_memberships", force: :cascade do |t|
    t.integer "room_id", null: false
    t.integer "person_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "message_count", default: 0, null: false
    t.index ["person_id"], name: "idx_room_memberships_person"
    t.index ["room_id", "person_id"], name: "unq_room_memberships_room_person", unique: true
  end

  create_table "rooms", force: :cascade do |t|
    t.integer "product_id", null: false
    t.text "name"
    t.text "name_canonical"
    t.integer "created_by_id", null: false
    t.integer "status", default: 0, null: false
    t.boolean "public", default: false, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "picture_file_name"
    t.string "picture_content_type"
    t.integer "picture_file_size"
    t.datetime "picture_updated_at"
    t.index ["product_id", "status"], name: "unq_rooms_product_status"
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
  add_foreign_key "badges", "action_types", name: "fk_badges_action_type", on_delete: :restrict
  add_foreign_key "badges", "products", name: "fk_badges_product", on_delete: :cascade
  add_foreign_key "blocks", "people", column: "blocked_id", name: "fk_blocks_people_blocked", on_delete: :cascade
  add_foreign_key "blocks", "people", column: "blocker_id", name: "fk_blocks_people_blocker", on_delete: :cascade
  add_foreign_key "followings", "people", column: "followed_id", name: "fk_followings_followed_id"
  add_foreign_key "followings", "people", column: "follower_id", name: "fk_followings_follower_id"
  add_foreign_key "levels", "products", name: "fk_levels_products"
  add_foreign_key "message_reports", "messages", name: "fk_message_reports_message", on_delete: :cascade
  add_foreign_key "message_reports", "people", name: "fk_message_reports_people", on_delete: :cascade
  add_foreign_key "messages", "people", name: "fk_messages_people", on_delete: :cascade
  add_foreign_key "messages", "rooms", name: "fk_messages_rooms", on_delete: :cascade
  add_foreign_key "notification_device_ids", "people", name: "fk_notification_device_ids_people", on_delete: :cascade
  add_foreign_key "people", "products", name: "fk_people_products", on_delete: :cascade
  add_foreign_key "post_reactions", "people", name: "fk_post_reactions_people", on_delete: :cascade
  add_foreign_key "post_reactions", "posts", name: "fk_post_reactions_post", on_delete: :cascade
  add_foreign_key "post_reports", "people", name: "fk_post_reports_people", on_delete: :cascade
  add_foreign_key "post_reports", "posts", name: "fk_post_reports_post", on_delete: :cascade
  add_foreign_key "posts", "people", name: "fk_posts_people", on_delete: :cascade
  add_foreign_key "relationships", "people", column: "requested_by_id", name: "fk_relationships_requested_by", on_delete: :cascade
  add_foreign_key "relationships", "people", column: "requested_to_id", name: "fk_relationships_requested_to", on_delete: :cascade
  add_foreign_key "room_memberships", "people", name: "fk_room_memberships_people", on_delete: :cascade
  add_foreign_key "room_memberships", "rooms", name: "fk_room_memberships_rooms", on_delete: :cascade
  add_foreign_key "rooms", "people", column: "created_by_id", name: "fk_rooms_created_by", on_delete: :restrict
  add_foreign_key "rooms", "products", name: "fk_rooms_products", on_delete: :cascade
end
