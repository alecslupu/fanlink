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

ActiveRecord::Schema.define(version: 20200120182704) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"
  enable_extension "pgcrypto"

  create_table "action_types", force: :cascade do |t|
    t.text "name", null: false
    t.text "internal_name", null: false
    t.integer "seconds_lag", default: 0, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.boolean "active", default: true, null: false
    t.integer "badge_actions_count"
    t.integer "badges_count"
    t.index ["internal_name"], name: "unq_action_types_internal_name", unique: true
    t.index ["name"], name: "unq_action_types_name", unique: true
  end

  create_table "activity_types", force: :cascade do |t|
    t.integer "activity_id", null: false
    t.text "atype_old"
    t.jsonb "value", default: {}, null: false
    t.boolean "deleted", default: false, null: false
    t.datetime "created_at", default: -> { "CURRENT_TIMESTAMP" }, null: false
    t.datetime "updated_at", default: -> { "CURRENT_TIMESTAMP" }, null: false
    t.integer "atype", default: 0, null: false
    t.index ["activity_id"], name: "ind_activity_id"
  end

  create_table "answers", force: :cascade do |t|
    t.integer "quiz_page_id"
    t.string "description", default: "", null: false
    t.boolean "is_correct", default: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "product_id", null: false
    t.index ["product_id"], name: "idx_answers_product"
    t.index ["quiz_page_id"], name: "idx_answers_quiz"
  end

  create_table "api_keys", force: :cascade do |t|
    t.integer "person_id", null: false
    t.string "key", null: false
    t.string "secret", null: false
  end

  create_table "assigned_push_notifications", force: :cascade do |t|
    t.integer "push_notification_id", null: false
    t.integer "assigned_id", null: false
    t.text "assigned_type", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["assigned_id", "assigned_type"], name: "idx_push_notifications_assigned"
    t.index ["push_notification_id"], name: "index_assigned_push_notifications_on_push_notification_id"
  end

  create_table "assigned_rewards", force: :cascade do |t|
    t.integer "reward_id", null: false
    t.integer "assigned_id", null: false
    t.text "assigned_type", null: false
    t.integer "max_times", default: 1, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["assigned_id", "assigned_type"], name: "index_assigned_rewards_on_assigned_id_and_assigned_type"
    t.index ["reward_id"], name: "index_assigned_rewards_on_reward_id"
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
    t.text "name_text_old"
    t.text "internal_name", null: false
    t.integer "action_type_id"
    t.integer "action_requirement", default: 1, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "point_value", default: 0, null: false
    t.string "picture_file_name"
    t.string "picture_content_type"
    t.integer "picture_file_size"
    t.datetime "picture_updated_at"
    t.text "description_text_old"
    t.datetime "issued_from"
    t.datetime "issued_to"
    t.jsonb "name", default: {}, null: false
    t.jsonb "description", default: {}, null: false
    t.index ["action_type_id"], name: "index_badges_on_action_type_id"
    t.index ["issued_from"], name: "ind_badges_issued_from"
    t.index ["issued_to"], name: "ind_badges_issued_to"
    t.index ["product_id", "internal_name"], name: "unq_badges_product_internal_name", unique: true
    t.index ["product_id", "name"], name: "unq_badges_product_name", unique: true
    t.index ["product_id"], name: "index_badges_on_product_id"
  end

  create_table "blocks", force: :cascade do |t|
    t.integer "blocker_id", null: false
    t.integer "blocked_id", null: false
    t.datetime "created_at", null: false
    t.index ["blocker_id", "blocked_id"], name: "unq_blocks_blocker_blocked", unique: true
    t.index ["blocker_id"], name: "ind_blocks_blocker"
  end

  create_table "categories", force: :cascade do |t|
    t.text "name", null: false
    t.integer "product_id", null: false
    t.integer "role", default: 0, null: false
    t.text "color"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.boolean "deleted", default: false, null: false
    t.integer "posts_count", default: 0
    t.index ["name"], name: "idx_category_names"
    t.index ["product_id"], name: "index_categories_on_product_id"
    t.index ["role"], name: "idx_category_roles"
  end

  create_table "censored_words", force: :cascade do |t|
    t.string "word"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "certcourse_pages", force: :cascade do |t|
    t.integer "certcourse_id"
    t.integer "certcourse_page_order", default: 0, null: false
    t.integer "duration", default: 0, null: false
    t.string "background_color_hex", default: "#000000", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "content_type"
    t.integer "product_id", null: false
    t.index ["certcourse_id"], name: "idx_certcourse_pages_certcourse"
    t.index ["product_id"], name: "idx_certcourse_pages_product"
  end

  create_table "certcourses", force: :cascade do |t|
    t.string "long_name", null: false
    t.string "short_name", null: false
    t.text "description", default: "", null: false
    t.string "color_hex", default: "#000000", null: false
    t.integer "status", default: 0, null: false
    t.integer "duration", default: 0, null: false
    t.boolean "is_completed", default: false
    t.text "copyright_text", default: "", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "product_id", null: false
    t.integer "certcourse_pages_count", default: 0
    t.index ["product_id"], name: "idx_certcourses_product"
  end

  create_table "certificate_certcourses", force: :cascade do |t|
    t.integer "certificate_id"
    t.integer "certcourse_id"
    t.integer "certcourse_order", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "product_id", null: false
    t.index ["certcourse_id", "certificate_id"], name: "idx_uniq_cid_cid", unique: true
    t.index ["certcourse_id"], name: "idx_certificate_certcourses_certcourse"
    t.index ["certificate_id"], name: "idx_certificate_certcourses_certificate"
    t.index ["product_id"], name: "idx_certificate_certcourses_product"
  end

  create_table "certificates", force: :cascade do |t|
    t.string "long_name", null: false
    t.string "short_name", null: false
    t.text "description", default: "", null: false
    t.integer "certificate_order", null: false
    t.string "color_hex", default: "#000000", null: false
    t.integer "status", default: 0, null: false
    t.integer "room_id"
    t.boolean "is_free", default: false
    t.string "sku_ios", default: "", null: false
    t.string "sku_android", default: "", null: false
    t.integer "validity_duration", default: 0, null: false
    t.integer "access_duration", default: 0, null: false
    t.boolean "certificate_issuable", default: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "template_image_file_name"
    t.string "template_image_content_type"
    t.integer "template_image_file_size"
    t.datetime "template_image_updated_at"
    t.integer "product_id", null: false
    t.index ["product_id"], name: "idx_certificates_product"
    t.index ["room_id"], name: "idx_certificates_room"
  end

  create_table "client_infos", force: :cascade do |t|
    t.integer "client_id", null: false
    t.string "code", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["client_id"], name: "index_client_infos_on_client_id"
    t.index ["code"], name: "index_client_infos_on_code"
  end

  create_table "client_to_people", force: :cascade do |t|
    t.integer "status", null: false
    t.integer "client_id", null: false
    t.integer "person_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "type", null: false
    t.index ["client_id"], name: "index_client_to_people_on_client_id"
  end

  create_table "config_items", force: :cascade do |t|
    t.bigint "product_id"
    t.string "item_key"
    t.string "item_value"
    t.string "type"
    t.boolean "enabled", default: true
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "parent_id"
    t.integer "lft", default: 0, null: false
    t.integer "rgt", default: 0, null: false
    t.integer "depth", default: 0, null: false
    t.integer "children_count", default: 0
    t.string "item_url"
    t.string "item_description"
    t.index ["product_id"], name: "index_config_items_on_product_id"
  end

  create_table "contests", force: :cascade do |t|
    t.integer "product_id", null: false
    t.text "name", null: false
    t.text "internal_name"
    t.text "description", null: false
    t.text "rules_url"
    t.text "contest_url"
    t.integer "status", default: 0
    t.boolean "deleted", default: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["product_id"], name: "index_contests_on_product_id"
  end

  create_table "coupons", force: :cascade do |t|
    t.integer "product_id", null: false
    t.text "code", null: false
    t.text "description", null: false
    t.text "url"
    t.boolean "deleted", default: false
    t.index ["product_id"], name: "index_coupons_on_product_id"
  end

  create_table "course_page_progresses", force: :cascade do |t|
    t.boolean "passed", default: false
    t.bigint "certcourse_page_id"
    t.bigint "person_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["certcourse_page_id"], name: "index_course_page_progresses_on_certcourse_page_id"
    t.index ["person_id"], name: "index_course_page_progresses_on_person_id"
  end

  create_table "courses", force: :cascade do |t|
    t.integer "semester_id", null: false
    t.text "name", null: false
    t.text "description", null: false
    t.datetime "start_date", null: false
    t.datetime "end_date"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.boolean "deleted", default: false
    t.index ["semester_id"], name: "index_courses_on_semester_id"
  end

  create_table "courseware_wishlist_wishlists", force: :cascade do |t|
    t.bigint "person_id"
    t.bigint "certificate_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["certificate_id"], name: "index_courseware_wishlist_wishlists_on_certificate_id"
    t.index ["person_id"], name: "index_courseware_wishlist_wishlists_on_person_id"
  end

  create_table "delayed_jobs", force: :cascade do |t|
    t.integer "priority", default: 0, null: false
    t.integer "attempts", default: 0, null: false
    t.text "handler", null: false
    t.text "last_error"
    t.datetime "run_at"
    t.datetime "locked_at"
    t.datetime "failed_at"
    t.string "locked_by"
    t.string "queue"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.index ["priority", "run_at"], name: "delayed_jobs_priority"
  end

  create_table "download_file_pages", force: :cascade do |t|
    t.bigint "certcourse_page_id"
    t.bigint "product_id"
    t.string "document_file_name"
    t.string "document_content_type"
    t.integer "document_file_size"
    t.datetime "document_updated_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.text "caption"
    t.index ["certcourse_page_id"], name: "index_download_file_pages_on_certcourse_page_id"
    t.index ["product_id"], name: "index_download_file_pages_on_product_id"
  end

  create_table "event_checkins", force: :cascade do |t|
    t.integer "event_id", null: false
    t.integer "person_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["event_id"], name: "idx_event_checkins_event"
    t.index ["person_id"], name: "idx_event_checkins_person"
  end

  create_table "events", force: :cascade do |t|
    t.integer "product_id", null: false
    t.text "name", null: false
    t.text "description"
    t.datetime "starts_at", null: false
    t.datetime "ends_at"
    t.text "ticket_url"
    t.text "place_identifier"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.boolean "deleted", default: false, null: false
    t.decimal "latitude", precision: 10, scale: 6
    t.decimal "longitude", precision: 10, scale: 6
    t.index ["ends_at"], name: "ind_events_ends_at"
    t.index ["product_id"], name: "ind_events_products"
    t.index ["starts_at"], name: "ind_events_starts_at"
  end

  create_table "followings", force: :cascade do |t|
    t.integer "follower_id", null: false
    t.integer "followed_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["followed_id"], name: "idx_followings_followed"
    t.index ["follower_id", "followed_id"], name: "unq_followings_follower_followed", unique: true
  end

  create_table "hacked_metrics", force: :cascade do |t|
    t.integer "product_id", null: false
    t.integer "person_id", null: false
    t.integer "action_type_id", null: false
    t.integer "identifier"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["action_type_id"], name: "idx_hacked_metrics_activity_type"
    t.index ["person_id"], name: "idx_hacked_metrics_person"
    t.index ["product_id"], name: "idx_hacked_metrics_product"
  end

  create_table "image_pages", force: :cascade do |t|
    t.integer "certcourse_page_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "image_file_name"
    t.string "image_content_type"
    t.integer "image_file_size"
    t.datetime "image_updated_at"
    t.integer "product_id", null: false
    t.index ["certcourse_page_id"], name: "idx_image_pages_certcourse_page"
    t.index ["product_id"], name: "idx_image_pages_product"
  end

  create_table "interests", force: :cascade do |t|
    t.integer "product_id", null: false
    t.integer "parent_id"
    t.jsonb "title", default: {}, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "order", default: 0, null: false
    t.index ["parent_id"], name: "idx_interests_parent"
    t.index ["product_id"], name: "idx_interests_product"
  end

  create_table "lessons", force: :cascade do |t|
    t.integer "course_id", null: false
    t.text "name", null: false
    t.text "description", null: false
    t.datetime "start_date", null: false
    t.datetime "end_date"
    t.text "video", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.boolean "deleted", default: false
    t.index ["course_id"], name: "index_lessons_on_course_id"
  end

  create_table "level_progresses", force: :cascade do |t|
    t.integer "person_id", null: false
    t.jsonb "points", default: {}, null: false
    t.integer "total", default: 0, null: false
    t.index ["person_id"], name: "index_level_progresses_on_person_id"
  end

  create_table "levels", force: :cascade do |t|
    t.integer "product_id", null: false
    t.text "name_text_old"
    t.text "internal_name", null: false
    t.integer "points", default: 1000, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "picture_file_name"
    t.string "picture_content_type"
    t.integer "picture_file_size"
    t.datetime "picture_updated_at"
    t.jsonb "description", default: {}, null: false
    t.jsonb "name", default: {}, null: false
    t.index ["product_id", "internal_name"], name: "unq_levels_product_internal_name"
    t.index ["product_id", "points"], name: "unq_levels_product_points"
  end

  create_table "merchandise", force: :cascade do |t|
    t.integer "product_id", null: false
    t.text "name_text_old"
    t.text "description_text_old"
    t.text "price"
    t.text "purchase_url"
    t.string "picture_file_name"
    t.string "picture_content_type"
    t.integer "picture_file_size"
    t.datetime "picture_updated_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.boolean "available", default: true, null: false
    t.integer "priority", default: 0, null: false
    t.jsonb "name", default: {}, null: false
    t.jsonb "description", default: {}, null: false
    t.boolean "deleted", default: false, null: false
    t.index ["product_id", "priority"], name: "idx_merchandise_product_priority"
    t.index ["product_id"], name: "idx_merchandise_product"
  end

  create_table "message_mentions", force: :cascade do |t|
    t.integer "message_id", null: false
    t.integer "person_id", null: false
    t.integer "location", default: 0, null: false
    t.integer "length", default: 0, null: false
    t.index ["message_id"], name: "ind_message_mentions_people"
    t.index ["person_id"], name: "index_message_mentions_on_person_id"
  end

  create_table "message_reports", force: :cascade do |t|
    t.integer "message_id", null: false
    t.integer "person_id", null: false
    t.text "reason"
    t.integer "status", default: 0, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["created_at"], name: "index_message_reports_on_created_at"
    t.index ["message_id"], name: "index_message_reports_on_message_id"
    t.index ["person_id"], name: "index_message_reports_on_person_id"
    t.index ["status"], name: "index_message_reports_on_status"
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
    t.string "audio_file_name"
    t.string "audio_content_type"
    t.integer "audio_file_size"
    t.datetime "audio_updated_at"
    t.index ["body"], name: "index_messages_on_body"
    t.index ["created_at"], name: "index_messages_on_created_at"
    t.index ["person_id"], name: "index_messages_on_person_id"
    t.index ["room_id"], name: "idx_messages_room"
  end

  create_table "notification_device_ids", force: :cascade do |t|
    t.integer "person_id", null: false
    t.text "device_identifier", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "device_type", default: 0, null: false
    t.boolean "not_registered", default: false, null: false
    t.index ["device_identifier"], name: "unq_notification_device_ids_device", unique: true
    t.index ["person_id"], name: "idx_notification_device_ids_person"
  end

  create_table "notifications", force: :cascade do |t|
    t.text "body", null: false
    t.bigint "person_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.boolean "for_followers", default: false, null: false
    t.integer "product_id", null: false
    t.index ["person_id"], name: "index_notifications_on_person_id"
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
    t.string "picture_file_name"
    t.string "picture_content_type"
    t.integer "picture_file_size"
    t.datetime "picture_updated_at"
    t.boolean "do_not_message_me", default: false, null: false
    t.boolean "pin_messages_from", default: false, null: false
    t.boolean "auto_follow", default: false, null: false
    t.integer "old_role", default: 0, null: false
    t.text "reset_password_token"
    t.datetime "reset_password_token_expires_at"
    t.datetime "reset_password_email_sent_at"
    t.boolean "product_account", default: false, null: false
    t.boolean "chat_banned", default: false, null: false
    t.boolean "recommended", default: false, null: false
    t.jsonb "designation", default: {}, null: false
    t.integer "gender", default: 0, null: false
    t.date "birthdate"
    t.text "city"
    t.text "country_code"
    t.text "biography"
    t.boolean "tester", default: false
    t.boolean "terminated", default: false
    t.text "terminated_reason"
    t.boolean "deleted", default: false
    t.bigint "role_id"
    t.boolean "authorized", default: true, null: false
    t.index ["created_at"], name: "index_people_on_created_at"
    t.index ["product_id", "auto_follow"], name: "idx_people_product_auto_follow"
    t.index ["product_id", "email"], name: "index_people_on_product_id_and_email"
    t.index ["product_id", "email"], name: "unq_people_product_email", unique: true
    t.index ["product_id", "facebookid"], name: "unq_people_product_facebook", unique: true
    t.index ["product_id", "username"], name: "index_people_on_product_id_and_username"
    t.index ["product_id", "username_canonical"], name: "unq_people_product_username_canonical", unique: true
    t.index ["role_id"], name: "index_people_on_role_id"
  end

  create_table "permission_policies", force: :cascade do |t|
    t.integer "action", default: 0, null: false
    t.integer "badge", default: 0, null: false
    t.integer "category", default: 0, null: false
    t.integer "event", default: 0, null: false
    t.integer "interest", default: 0, null: false
    t.integer "level", default: 0, null: false
    t.integer "merchandise", default: 0, null: false
    t.integer "message", default: 0, null: false
    t.integer "people", default: 0, null: false
    t.integer "poll", default: 0, null: false
    t.integer "portal_notification", default: 0, null: false
    t.integer "post", default: 0, null: false
    t.integer "product_beacon", default: 0, null: false
    t.integer "product", default: 0, null: false
    t.integer "quest", default: 0, null: false
    t.integer "reward", default: 0, null: false
    t.integer "room", default: 0, null: false
    t.integer "education", default: 0, null: false
    t.string "permissable_type"
    t.bigint "permissable_id"
    t.index ["permissable_type", "permissable_id"], name: "permissable_policies"
  end

  create_table "person_certcourses", force: :cascade do |t|
    t.integer "person_id", null: false
    t.integer "certcourse_id", null: false
    t.integer "last_completed_page_id"
    t.boolean "is_completed", default: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["certcourse_id"], name: "idx_person_certcourses_certcourse"
    t.index ["person_id", "certcourse_id"], name: "idx_uniq_pc_pid_cid2", unique: true
    t.index ["person_id"], name: "idx_person_certcourses_person"
  end

  create_table "person_certificates", force: :cascade do |t|
    t.integer "person_id", null: false
    t.integer "certificate_id", null: false
    t.string "full_name", default: "", null: false
    t.datetime "issued_date"
    t.integer "validity_duration", default: 0, null: false
    t.bigint "amount_paid", default: 0, null: false
    t.string "currency", default: "", null: false
    t.boolean "fee_waived", default: false
    t.datetime "purchased_waived_date"
    t.integer "access_duration", default: 0, null: false
    t.string "purchased_order_id"
    t.integer "purchased_platform", default: 0, null: false
    t.string "purchased_sku"
    t.string "unique_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "issued_certificate_image_file_name"
    t.string "issued_certificate_image_content_type"
    t.integer "issued_certificate_image_file_size"
    t.datetime "issued_certificate_image_updated_at"
    t.string "issued_certificate_pdf_file_name"
    t.string "issued_certificate_pdf_content_type"
    t.integer "issued_certificate_pdf_file_size"
    t.datetime "issued_certificate_pdf_updated_at"
    t.string "receipt_id"
    t.boolean "is_completed", default: false
    t.index ["certificate_id"], name: "idx_person_certificates_certificate"
    t.index ["person_id", "certificate_id"], name: "idx_uniq_pc_pid_cid", unique: true
    t.index ["person_id"], name: "idx_person_certificates_person"
  end

  create_table "person_interests", force: :cascade do |t|
    t.integer "person_id", null: false
    t.integer "interest_id", null: false
    t.index ["interest_id"], name: "idx_person_interests_interest"
    t.index ["person_id"], name: "idx_person_interests_person"
  end

  create_table "person_poll_options", force: :cascade do |t|
    t.integer "person_id", null: false
    t.integer "poll_option_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["person_id"], name: "idx_person_poll_options_person"
    t.index ["poll_option_id"], name: "idx_person_poll_options_poll_option"
  end

  create_table "person_quizzes", force: :cascade do |t|
    t.integer "person_id", null: false
    t.integer "quiz_page_id", null: false
    t.integer "answer_id"
    t.string "fill_in_response"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["person_id"], name: "idx_person_quiz_pages_person"
    t.index ["quiz_page_id"], name: "idx_person_quiz_pages_quiz_page_id"
  end

  create_table "person_rewards", force: :cascade do |t|
    t.integer "person_id", null: false
    t.integer "reward_id", null: false
    t.text "source", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.boolean "deleted", default: false
    t.index ["person_id", "reward_id"], name: "index_person_rewards_on_person_id_and_reward_id"
  end

  create_table "pin_messages", force: :cascade do |t|
    t.integer "person_id", null: false
    t.integer "room_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["person_id", "room_id"], name: "index_pin_messages_on_person_id_and_room_id"
    t.index ["person_id"], name: "index_pin_messages_on_person_id"
    t.index ["room_id"], name: "index_pin_messages_on_room_id"
  end

  create_table "poll_options", force: :cascade do |t|
    t.integer "poll_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.jsonb "description", default: {}, null: false
    t.integer "person_poll_options_count"
    t.index ["poll_id"], name: "idx_poll_options_poll"
  end

  create_table "polls", force: :cascade do |t|
    t.integer "poll_type"
    t.integer "poll_type_id"
    t.datetime "start_date", null: false
    t.integer "duration", default: 0, null: false
    t.integer "poll_status", default: 0, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.datetime "end_date", default: "2020-02-04 16:42:01"
    t.jsonb "description", default: {}, null: false
    t.integer "product_id", null: false
    t.index ["poll_type", "poll_type_id"], name: "unq_polls_type_poll_type_id", unique: true
    t.index ["product_id"], name: "idx_polls_product"
  end

  create_table "portal_accesses", force: :cascade do |t|
    t.integer "person_id", null: false
    t.integer "post", default: 0, null: false
    t.integer "chat", default: 0, null: false
    t.integer "event", default: 0, null: false
    t.integer "merchandise", default: 0, null: false
    t.integer "user", default: 0, null: false
    t.integer "badge", default: 0, null: false
    t.integer "reward", default: 0, null: false
    t.integer "quest", default: 0, null: false
    t.integer "beacon", default: 0, null: false
    t.integer "reporting", default: 0, null: false
    t.integer "interest", default: 0, null: false
    t.integer "courseware", default: 0, null: false
    t.integer "trivia", default: 0, null: false
    t.integer "admin"
    t.integer "root", default: 0
    t.integer "portal_notification", default: 0, null: false
    t.index ["person_id"], name: "index_portal_accesses_on_person_id"
  end

  create_table "portal_notifications", force: :cascade do |t|
    t.integer "product_id", null: false
    t.jsonb "body", default: {}, null: false
    t.datetime "send_me_at", null: false
    t.integer "sent_status", default: 0, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["product_id"], name: "idx_portal_notifications_products"
    t.index ["send_me_at"], name: "idx_portal_notifications_send_me_at"
    t.index ["sent_status"], name: "idx_portal_notifications_sent_status"
  end

  create_table "post_comment_mentions", force: :cascade do |t|
    t.integer "post_comment_id", null: false
    t.integer "person_id", null: false
    t.integer "location", default: 0, null: false
    t.integer "length", default: 0, null: false
    t.index ["person_id"], name: "index_post_comment_mentions_on_person_id"
    t.index ["post_comment_id"], name: "ind_post_comment_mentions_post_comments"
  end

  create_table "post_comment_reports", force: :cascade do |t|
    t.integer "post_comment_id", null: false
    t.integer "person_id", null: false
    t.text "reason"
    t.integer "status", default: 0, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["created_at"], name: "index_post_comment_reports_on_created_at"
    t.index ["person_id"], name: "index_post_comment_reports_on_person_id"
    t.index ["post_comment_id"], name: "idx_post_comment_reports_post_comment"
    t.index ["status"], name: "index_post_comment_reports_on_status"
  end

  create_table "post_comments", force: :cascade do |t|
    t.integer "post_id", null: false
    t.integer "person_id", null: false
    t.text "body", null: false
    t.boolean "hidden", default: false, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["body"], name: "index_post_comments_on_body"
    t.index ["created_at"], name: "index_post_comments_on_created_at"
    t.index ["person_id"], name: "index_post_comments_on_person_id"
    t.index ["post_id"], name: "idx_post_comments_post"
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
    t.index ["created_at"], name: "index_post_reports_on_created_at"
    t.index ["person_id"], name: "index_post_reports_on_person_id"
    t.index ["post_id"], name: "idx_post_reports_post"
    t.index ["status"], name: "index_post_reports_on_status"
  end

  create_table "post_tags", id: false, force: :cascade do |t|
    t.bigint "post_id", null: false
    t.bigint "tag_id", null: false
    t.index ["post_id", "tag_id"], name: "index_post_tags_on_post_id_and_tag_id"
    t.index ["tag_id", "post_id"], name: "index_post_tags_on_tag_id_and_post_id"
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
    t.jsonb "body", default: {}, null: false
    t.integer "priority", default: 0, null: false
    t.boolean "recommended", default: false, null: false
    t.boolean "notify_followers", default: false, null: false
    t.string "audio_file_name"
    t.string "audio_content_type"
    t.integer "audio_file_size"
    t.datetime "audio_updated_at"
    t.integer "category_id"
    t.string "video_file_name"
    t.string "video_content_type"
    t.integer "video_file_size"
    t.datetime "video_updated_at"
    t.string "video_job_id"
    t.jsonb "video_transcoded", default: {}, null: false
    t.integer "post_comments_count", default: 0
    t.boolean "pinned", default: false
    t.index ["body"], name: "index_posts_on_body", using: :gin
    t.index ["category_id"], name: "index_posts_on_category_id"
    t.index ["created_at"], name: "index_posts_on_created_at"
    t.index ["person_id", "priority"], name: "idx_posts_person_priority"
    t.index ["person_id"], name: "idx_posts_person"
    t.index ["recommended"], name: "index_posts_on_recommended", where: "(recommended = true)"
    t.index ["status"], name: "index_posts_on_status"
  end

  create_table "product_beacons", force: :cascade do |t|
    t.integer "product_id", null: false
    t.text "beacon_pid", null: false
    t.integer "attached_to"
    t.boolean "deleted", default: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.uuid "uuid"
    t.integer "lower", null: false
    t.integer "upper", null: false
    t.index ["beacon_pid"], name: "ind_beacons_pid"
    t.index ["product_id"], name: "ind_beacons_products"
  end

  create_table "products", force: :cascade do |t|
    t.string "name", null: false
    t.string "internal_name", null: false
    t.boolean "enabled", default: false, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.boolean "can_have_supers", default: false, null: false
    t.integer "age_requirement", default: 0
    t.string "logo_file_name"
    t.string "logo_content_type"
    t.integer "logo_file_size"
    t.datetime "logo_updated_at"
    t.string "color_primary", default: "4B73D7"
    t.string "color_primary_text", default: "FFFFFF"
    t.string "color_secondary", default: "CDE5FF"
    t.string "color_secondary_text", default: "000000"
    t.string "color_tertiary", default: "FFFFFF"
    t.string "color_tertiary_text", default: "000000"
    t.string "color_accent", default: "FFF537"
    t.string "color_accent_text", default: "FFF537"
    t.string "color_title_text", default: "FFF537"
    t.integer "navigation_bar_style", default: 1
    t.integer "status_bar_style", default: 1
    t.integer "toolbar_style", default: 1
    t.integer "features", default: 0, null: false
    t.string "contact_email"
    t.text "privacy_url"
    t.text "terms_url"
    t.text "android_url"
    t.text "ios_url"
    t.index ["internal_name"], name: "unq_products_internal_name", unique: true
    t.index ["name"], name: "unq_products_name", unique: true
  end

  create_table "push_notifications", force: :cascade do |t|
    t.integer "product_id", null: false
    t.jsonb "body", default: {}, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["product_id"], name: "idx_push_notifications_products"
  end

  create_table "quest_activities", force: :cascade do |t|
    t.text "description_text_old"
    t.text "hint_text_old"
    t.boolean "deleted", default: false
    t.string "activity_code"
    t.string "picture_file_name"
    t.string "picture_content_type"
    t.integer "picture_file_size"
    t.datetime "picture_updated_at"
    t.text "picture_meta"
    t.jsonb "hint", default: {}, null: false
    t.jsonb "description", default: {}, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "step_id", null: false
    t.integer "reward_id"
    t.jsonb "title", default: {}, null: false
    t.index ["reward_id"], name: "idx_quest_activities_rewards"
    t.index ["step_id"], name: "index_quest_activities_on_step_id"
  end

  create_table "quest_completed", force: :cascade do |t|
    t.integer "quest_id", null: false
    t.integer "person_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["person_id"], name: "index_quest_completed_on_person_id"
    t.index ["quest_id"], name: "index_quest_completed_on_quest_id"
  end

  create_table "quest_completions", force: :cascade do |t|
    t.integer "person_id", null: false
    t.integer "activity_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.text "status_old", default: "0", null: false
    t.integer "step_id", null: false
    t.integer "status", default: 0, null: false
    t.index ["activity_id"], name: "index_quest_completions_on_activity_id"
    t.index ["person_id"], name: "ind_quest_person_completions"
    t.index ["step_id"], name: "idx_completions_step"
  end

  create_table "quests", force: :cascade do |t|
    t.integer "product_id", null: false
    t.integer "event_id"
    t.text "name_text_old"
    t.text "internal_name", null: false
    t.text "description_text_old"
    t.integer "status", default: 2, null: false
    t.datetime "starts_at", null: false
    t.datetime "ends_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "picture_file_name"
    t.string "picture_content_type"
    t.integer "picture_file_size"
    t.datetime "picture_updated_at"
    t.text "picture_meta"
    t.jsonb "name", default: {}, null: false
    t.jsonb "description", default: {}, null: false
    t.integer "reward_id"
    t.index ["created_at"], name: "index_quests_on_created_at"
    t.index ["description"], name: "index_quests_on_description", using: :gin
    t.index ["ends_at"], name: "index_quests_on_ends_at", where: "(ends_at IS NOT NULL)"
    t.index ["event_id"], name: "ind_quests_events", where: "(event_id IS NOT NULL)"
    t.index ["internal_name"], name: "ind_quests_internal_name"
    t.index ["name"], name: "index_quests_on_name", using: :gin
    t.index ["product_id", "internal_name"], name: "index_quests_on_product_id_and_internal_name"
    t.index ["product_id"], name: "ind_quests_products"
    t.index ["reward_id"], name: "idx_quests_rewards"
    t.index ["starts_at"], name: "index_quests_on_starts_at"
    t.index ["status"], name: "index_quests_on_status"
  end

  create_table "quiz_pages", force: :cascade do |t|
    t.integer "certcourse_page_id"
    t.boolean "is_optional", default: false
    t.string "quiz_text", default: "", null: false
    t.integer "wrong_answer_page_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "product_id", null: false
    t.boolean "is_survey", default: false
    t.index ["certcourse_page_id"], name: "idx_quiz_pages_certcourse_page"
    t.index ["product_id"], name: "idx_quiz_pages_product"
  end

  create_table "referral_referred_people", force: :cascade do |t|
    t.bigint "inviter_id"
    t.bigint "invited_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["invited_id"], name: "index_referral_referred_people_on_invited_id"
    t.index ["inviter_id"], name: "index_referral_referred_people_on_inviter_id"
  end

  create_table "referral_user_codes", force: :cascade do |t|
    t.bigint "person_id"
    t.string "unique_code"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["person_id"], name: "index_referral_user_codes_on_person_id"
    t.index ["unique_code"], name: "index_referral_user_codes_on_unique_code", unique: true
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

  create_table "reward_progresses", force: :cascade do |t|
    t.integer "reward_id", null: false
    t.integer "person_id", null: false
    t.text "series"
    t.jsonb "actions", default: {}, null: false
    t.integer "total", default: 0, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["person_id"], name: "index_reward_progresses_on_person_id"
    t.index ["reward_id"], name: "index_reward_progresses_on_reward_id"
  end

  create_table "rewards", force: :cascade do |t|
    t.integer "product_id", null: false
    t.jsonb "name", default: {}, null: false
    t.text "internal_name", null: false
    t.integer "reward_type", default: 0, null: false
    t.integer "reward_type_id", null: false
    t.text "series"
    t.integer "completion_requirement", default: 1, null: false
    t.integer "points", default: 0
    t.integer "status", default: 0, null: false
    t.boolean "deleted", default: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["product_id", "internal_name"], name: "unq_rewards_product_internal_name", unique: true
    t.index ["product_id", "name"], name: "unq_rewards_product_name", unique: true
    t.index ["product_id"], name: "idx_rewards_product"
    t.index ["reward_type", "reward_type_id"], name: "unq_rewards_type_reward_type_id", unique: true
    t.index ["series"], name: "index_rewards_on_series", where: "(series IS NOT NULL)"
  end

  create_table "roles", force: :cascade do |t|
    t.string "name", null: false
    t.string "internal_name", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "post", default: 0, null: false
    t.integer "chat", default: 0, null: false
    t.integer "event", default: 0, null: false
    t.integer "merchandise", default: 0, null: false
    t.integer "badge", default: 0, null: false
    t.integer "reward", default: 0, null: false
    t.integer "quest", default: 0, null: false
    t.integer "beacon", default: 0, null: false
    t.integer "reporting", default: 0, null: false
    t.integer "interest", default: 0, null: false
    t.integer "courseware", default: 0, null: false
    t.integer "trivia", default: 0, null: false
    t.integer "admin", default: 0, null: false
    t.integer "root", default: 0, null: false
    t.integer "user", default: 0, null: false
    t.integer "portal_notification", default: 0, null: false
  end

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
    t.text "name_text_old"
    t.integer "created_by_id"
    t.integer "status", default: 0, null: false
    t.boolean "public", default: false, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "picture_file_name"
    t.string "picture_content_type"
    t.integer "picture_file_size"
    t.datetime "picture_updated_at"
    t.jsonb "name", default: {}, null: false
    t.jsonb "description", default: {}, null: false
    t.integer "order", default: 0, null: false
    t.bigint "last_message_timestamp", default: 0
    t.index ["created_by_id"], name: "index_rooms_on_created_by_id"
    t.index ["product_id", "status"], name: "unq_rooms_product_status"
  end

  create_table "semesters", force: :cascade do |t|
    t.integer "product_id", null: false
    t.text "name", null: false
    t.text "description", null: false
    t.datetime "start_date", null: false
    t.datetime "end_date"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.boolean "deleted", default: false
    t.index ["product_id"], name: "index_semesters_on_product_id"
  end

  create_table "static_contents", force: :cascade do |t|
    t.jsonb "content", default: "{}", null: false
    t.jsonb "title", default: "{}", null: false
    t.string "slug", null: false
    t.integer "product_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["slug"], name: "index_static_contents_on_slug", unique: true
  end

  create_table "step_completed", force: :cascade do |t|
    t.integer "step_id", null: false
    t.integer "person_id", null: false
    t.text "status_old", default: "0", null: false
    t.integer "quest_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "status", default: 0, null: false
    t.index ["person_id"], name: "idx_step_completed_person"
    t.index ["quest_id"], name: "idx_step_completed_quest"
    t.index ["step_id"], name: "idx_step_completed_step"
  end

  create_table "step_unlocks", force: :cascade do |t|
    t.uuid "step_id", null: false
    t.uuid "unlock_id", null: false
    t.index ["step_id", "unlock_id"], name: "index_step_unlocks_on_step_id_and_unlock_id"
    t.index ["step_id"], name: "index_step_unlocks_on_step_id"
  end

  create_table "steps", force: :cascade do |t|
    t.integer "quest_id", null: false
    t.text "display"
    t.boolean "deleted", default: false, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "int_unlocks", default: [], null: false, array: true
    t.integer "initial_status", default: 0, null: false
    t.integer "reward_id"
    t.integer "delay_unlock", default: 0
    t.uuid "uuid", default: -> { "gen_random_uuid()" }
    t.text "unlocks"
    t.datetime "unlocks_at"
    t.index ["int_unlocks"], name: "index_steps_on_int_unlocks", using: :gin
    t.index ["quest_id"], name: "index_steps_on_quest_id"
    t.index ["reward_id"], name: "idx_steps_rewards"
  end

  create_table "tags", force: :cascade do |t|
    t.text "name", null: false
    t.integer "product_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.boolean "deleted", default: false, null: false
    t.integer "posts_count", default: 0
    t.index ["name"], name: "idx_tag_names"
    t.index ["product_id"], name: "idx_tag_products"
  end

  create_table "trivia_answers", force: :cascade do |t|
    t.bigint "person_id"
    t.bigint "trivia_question_id"
    t.string "answered"
    t.integer "time"
    t.boolean "is_correct", default: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "product_id", null: false
    t.index ["person_id"], name: "index_trivia_answers_on_person_id"
    t.index ["product_id"], name: "idx_trivia_answers_product"
    t.index ["trivia_question_id"], name: "index_trivia_answers_on_trivia_question_id"
  end

  create_table "trivia_available_answers", force: :cascade do |t|
    t.bigint "trivia_question_id"
    t.string "name"
    t.string "hint"
    t.boolean "is_correct", default: false, null: false
    t.integer "status", default: 0, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "product_id", null: false
    t.index ["product_id"], name: "idx_trivia_available_answers_product"
    t.index ["trivia_question_id"], name: "index_trivia_available_answers_on_trivia_question_id"
  end

  create_table "trivia_available_questions", force: :cascade do |t|
    t.string "title"
    t.integer "cooldown_period"
    t.integer "time_limit"
    t.integer "status"
    t.string "type"
    t.integer "topic_id"
    t.integer "complexity"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "product_id", null: false
    t.index ["product_id"], name: "idx_trivia_available_questions_product"
  end

  create_table "trivia_game_leaderboards", force: :cascade do |t|
    t.bigint "trivia_game_id"
    t.integer "points"
    t.integer "position"
    t.integer "average_time", default: 0
    t.bigint "person_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "product_id", null: false
    t.index ["person_id"], name: "index_trivia_game_leaderboards_on_person_id"
    t.index ["product_id"], name: "idx_trivia_game_leaderboards_product"
    t.index ["trivia_game_id"], name: "index_trivia_game_leaderboards_on_trivia_game_id"
  end

  create_table "trivia_games", force: :cascade do |t|
    t.text "description", default: "", null: false
    t.integer "round_count"
    t.string "long_name", null: false
    t.string "short_name", null: false
    t.bigint "room_id"
    t.bigint "product_id"
    t.integer "status", default: 0, null: false
    t.integer "leaderboard_size", default: 100
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "start_date"
    t.integer "end_date"
    t.string "picture_file_name"
    t.string "picture_content_type"
    t.integer "picture_file_size"
    t.datetime "picture_updated_at"
    t.index ["product_id"], name: "index_trivia_games_on_product_id"
    t.index ["room_id"], name: "index_trivia_games_on_room_id"
  end

  create_table "trivia_picture_available_answers", force: :cascade do |t|
    t.bigint "question_id"
    t.boolean "is_correct", default: false, null: false
    t.integer "status", default: 0, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "picture_file_name"
    t.string "picture_content_type"
    t.integer "picture_file_size"
    t.datetime "picture_updated_at"
    t.integer "product_id", null: false
    t.index ["product_id"], name: "idx_trivia_picture_available_answers_product"
    t.index ["question_id"], name: "index_trivia_picture_available_answers_on_question_id"
  end

  create_table "trivia_prizes", force: :cascade do |t|
    t.bigint "trivia_game_id"
    t.integer "status", default: 0, null: false
    t.text "description"
    t.integer "position", default: 1, null: false
    t.string "photo_file_name"
    t.integer "photo_file_size"
    t.string "photo_content_type"
    t.string "photo_updated_at"
    t.boolean "is_delivered", default: false
    t.integer "prize_type", default: 0
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "product_id", null: false
    t.index ["product_id"], name: "idx_trivia_prizes_product"
    t.index ["trivia_game_id"], name: "index_trivia_prizes_on_trivia_game_id"
  end

  create_table "trivia_question_leaderboards", force: :cascade do |t|
    t.bigint "trivia_question_id"
    t.integer "points"
    t.bigint "person_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "product_id", null: false
    t.index ["person_id"], name: "index_trivia_question_leaderboards_on_person_id"
    t.index ["product_id"], name: "idx_trivia_question_leaderboards_product"
    t.index ["trivia_question_id"], name: "index_trivia_question_leaderboards_on_trivia_question_id"
  end

  create_table "trivia_questions", force: :cascade do |t|
    t.bigint "trivia_round_id"
    t.integer "time_limit"
    t.string "type"
    t.integer "question_order", default: 1, null: false
    t.integer "cooldown_period", default: 5
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "start_date"
    t.integer "end_date"
    t.integer "available_question_id"
    t.integer "product_id", null: false
    t.index ["product_id"], name: "idx_trivia_questions_product"
    t.index ["trivia_round_id"], name: "index_trivia_questions_on_trivia_round_id"
  end

  create_table "trivia_round_leaderboards", force: :cascade do |t|
    t.bigint "trivia_round_id"
    t.integer "points"
    t.integer "position"
    t.bigint "person_id"
    t.integer "average_time", default: 0
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "product_id", null: false
    t.index ["person_id"], name: "index_trivia_round_leaderboards_on_person_id"
    t.index ["product_id"], name: "idx_trivia_round_leaderboards_product"
    t.index ["trivia_round_id"], name: "index_trivia_round_leaderboards_on_trivia_round_id"
  end

  create_table "trivia_rounds", force: :cascade do |t|
    t.integer "question_count"
    t.bigint "trivia_game_id"
    t.integer "leaderboard_size", default: 100
    t.integer "status", default: 0, null: false
    t.integer "complexity", default: 1
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "start_date"
    t.integer "end_date"
    t.integer "product_id", null: false
    t.index ["product_id"], name: "idx_trivia_rounds_product"
    t.index ["trivia_game_id"], name: "index_trivia_rounds_on_trivia_game_id"
  end

  create_table "trivia_subscribers", force: :cascade do |t|
    t.bigint "person_id"
    t.bigint "trivia_game_id"
    t.boolean "subscribed", default: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "product_id", null: false
    t.index ["person_id"], name: "index_trivia_subscribers_on_person_id"
    t.index ["product_id"], name: "idx_trivia_subscribers_product"
    t.index ["trivia_game_id"], name: "index_trivia_subscribers_on_trivia_game_id"
  end

  create_table "trivia_topics", force: :cascade do |t|
    t.string "name"
    t.integer "status"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "product_id", null: false
    t.index ["product_id"], name: "idx_trivia_topics_product"
  end

  create_table "urls", force: :cascade do |t|
    t.integer "product_id", null: false
    t.text "displayed_url", null: false
    t.boolean "protected", default: false
    t.boolean "deleted", default: false
    t.index ["product_id"], name: "index_urls_on_product_id"
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

  create_table "video_pages", force: :cascade do |t|
    t.integer "certcourse_page_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "video_file_name"
    t.string "video_content_type"
    t.integer "video_file_size"
    t.datetime "video_updated_at"
    t.integer "product_id", null: false
    t.index ["certcourse_page_id"], name: "idx_video_pages_certcourse_page"
    t.index ["product_id"], name: "idx_video_pages_product"
  end

  add_foreign_key "activity_types", "quest_activities", column: "activity_id", name: "fk_activity_types_quest_activities"
  add_foreign_key "answers", "products", name: "fk_answers_products", on_delete: :cascade
  add_foreign_key "answers", "quiz_pages", name: "fk_answers_quiz"
  add_foreign_key "authentications", "people", name: "fk_authentications_people"
  add_foreign_key "badge_actions", "action_types", name: "fk_badge_actions_action_types", on_delete: :restrict
  add_foreign_key "badge_actions", "people", name: "fk_badge_actions_people", on_delete: :cascade
  add_foreign_key "badge_awards", "badges", name: "fk_badge_awards_badges", on_delete: :restrict
  add_foreign_key "badge_awards", "people", name: "fk_badge_awards_people", on_delete: :cascade
  add_foreign_key "badges", "action_types", name: "fk_badges_action_type", on_delete: :restrict
  add_foreign_key "badges", "products", name: "fk_badges_product", on_delete: :cascade
  add_foreign_key "badges", "products", name: "fk_badges_products", on_delete: :cascade
  add_foreign_key "blocks", "people", column: "blocked_id", name: "fk_blocks_people_blocked", on_delete: :cascade
  add_foreign_key "blocks", "people", column: "blocker_id", name: "fk_blocks_people_blocker", on_delete: :cascade
  add_foreign_key "certcourse_pages", "certcourses", name: "fk_certcourse_pages_certcourse"
  add_foreign_key "certcourse_pages", "products", name: "fk_certcourse_pages_products", on_delete: :cascade
  add_foreign_key "certcourses", "products", name: "fk_certcourses_products", on_delete: :cascade
  add_foreign_key "certificate_certcourses", "certcourses", name: "fk_certificate_certcourses_certcourse"
  add_foreign_key "certificate_certcourses", "certificates", name: "fk_certificate_certcourses_certificate"
  add_foreign_key "certificate_certcourses", "products", name: "fk_certificate_certcourses_products", on_delete: :cascade
  add_foreign_key "certificates", "products", name: "fk_certificates_products", on_delete: :cascade
  add_foreign_key "certificates", "rooms", name: "fk_certificates_room"
  add_foreign_key "config_items", "products"
  add_foreign_key "courseware_wishlist_wishlists", "certificates"
  add_foreign_key "courseware_wishlist_wishlists", "people"
  add_foreign_key "download_file_pages", "certcourse_pages"
  add_foreign_key "download_file_pages", "products"
  add_foreign_key "event_checkins", "events", name: "fk_event_checkins_event"
  add_foreign_key "events", "products", name: "fk_events_products"
  add_foreign_key "followings", "people", column: "followed_id", name: "fk_followings_followed_id"
  add_foreign_key "followings", "people", column: "follower_id", name: "fk_followings_follower_id"
  add_foreign_key "image_pages", "certcourse_pages", name: "fk_image_pages_certcourse_page"
  add_foreign_key "image_pages", "products", name: "fk_image_products", on_delete: :cascade
  add_foreign_key "interests", "products", name: "fk_interests_products"
  add_foreign_key "levels", "products", name: "fk_levels_products"
  add_foreign_key "merchandise", "products", name: "fk_merchandise_products"
  add_foreign_key "message_mentions", "messages", name: "fk_message_mentions_messages", on_delete: :cascade
  add_foreign_key "message_mentions", "people", name: "fk_message_mentions_people", on_delete: :cascade
  add_foreign_key "message_reports", "messages", name: "fk_message_reports_message", on_delete: :cascade
  add_foreign_key "message_reports", "people", name: "fk_message_reports_people", on_delete: :cascade
  add_foreign_key "messages", "people", name: "fk_messages_people", on_delete: :cascade
  add_foreign_key "messages", "people", name: "fk_portal_access_people", on_delete: :cascade
  add_foreign_key "messages", "rooms", name: "fk_messages_rooms", on_delete: :cascade
  add_foreign_key "notification_device_ids", "people", name: "fk_notification_device_ids_people", on_delete: :cascade
  add_foreign_key "notifications", "people"
  add_foreign_key "people", "products", name: "fk_people_products", on_delete: :cascade
  add_foreign_key "people", "roles"
  add_foreign_key "person_certcourses", "certcourses", name: "fk_person_certcourses_certcourse"
  add_foreign_key "person_certcourses", "people", name: "fk_person_certcourses_person"
  add_foreign_key "person_certificates", "certificates", name: "fk_person_certificates_certificate"
  add_foreign_key "person_certificates", "people", name: "fk_person_certificates_person"
  add_foreign_key "person_interests", "interests", name: "fk_person_interests_interest"
  add_foreign_key "person_interests", "people", name: "fk_event_checkins_person"
  add_foreign_key "person_interests", "people", name: "fk_person_interests_person"
  add_foreign_key "person_poll_options", "people", name: "fk_person_poll_options_person"
  add_foreign_key "person_poll_options", "poll_options", name: "fk_person_poll_options_poll_option"
  add_foreign_key "person_quizzes", "people", name: "fk_person_quiz_pages_person"
  add_foreign_key "person_quizzes", "quiz_pages", name: "fk_person_quiz_pages_quiz_page_id"
  add_foreign_key "poll_options", "polls", name: "idx_poll_options_poll"
  add_foreign_key "polls", "products", name: "fk_polls_products", on_delete: :cascade
  add_foreign_key "portal_notifications", "products", name: "fk_portal_notifications_products", on_delete: :cascade
  add_foreign_key "post_comment_mentions", "people", name: "fk_post_comment_mentions_people", on_delete: :cascade
  add_foreign_key "post_comment_mentions", "post_comments", name: "fk_post_comment_mentions_post_comments", on_delete: :cascade
  add_foreign_key "post_comment_reports", "people", name: "fk_post__comment_reports_people", on_delete: :cascade
  add_foreign_key "post_comment_reports", "post_comments", name: "fk_post_comment_reports_post_comments", on_delete: :cascade
  add_foreign_key "post_comments", "people", name: "fk_post_comments_people", on_delete: :cascade
  add_foreign_key "post_comments", "posts", name: "fk_post_comments_post", on_delete: :cascade
  add_foreign_key "post_reactions", "people", name: "fk_post_reactions_people", on_delete: :cascade
  add_foreign_key "post_reactions", "posts", name: "fk_post_reactions_post", on_delete: :cascade
  add_foreign_key "post_reports", "people", name: "fk_post_reports_people", on_delete: :cascade
  add_foreign_key "post_reports", "posts", name: "fk_post_reports_post", on_delete: :cascade
  add_foreign_key "posts", "people", name: "fk_posts_people", on_delete: :cascade
  add_foreign_key "product_beacons", "products", name: "fk_beacons_products"
  add_foreign_key "push_notifications", "products", name: "fk_push_notifications_products", on_delete: :cascade
  add_foreign_key "quest_activities", "rewards", name: "fk_quest_activities_rewards"
  add_foreign_key "quest_activities", "steps", name: "fk_activities_steps"
  add_foreign_key "quest_completed", "people", name: "fk_quest_completeds_people"
  add_foreign_key "quest_completed", "quests", name: "fk_quest_completeds_quests"
  add_foreign_key "quest_completions", "steps", name: "fk_completions_steps"
  add_foreign_key "quests", "products", name: "fk_quests_products"
  add_foreign_key "quests", "rewards", name: "fk_quests_rewards"
  add_foreign_key "quiz_pages", "certcourse_pages", name: "fk_quiz_pages_certcourse_page"
  add_foreign_key "quiz_pages", "products", name: "fk_quiz_products", on_delete: :cascade
  add_foreign_key "referral_referred_people", "people", column: "invited_id"
  add_foreign_key "referral_referred_people", "people", column: "inviter_id"
  add_foreign_key "referral_user_codes", "people"
  add_foreign_key "relationships", "people", column: "requested_by_id", name: "fk_relationships_requested_by", on_delete: :cascade
  add_foreign_key "relationships", "people", column: "requested_to_id", name: "fk_relationships_requested_to", on_delete: :cascade
  add_foreign_key "rewards", "products", name: "fk_rewards_product", on_delete: :cascade
  add_foreign_key "room_memberships", "people", name: "fk_room_memberships_people", on_delete: :cascade
  add_foreign_key "room_memberships", "rooms", name: "fk_room_memberships_rooms", on_delete: :cascade
  add_foreign_key "rooms", "people", column: "created_by_id", name: "fk_rooms_created_by", on_delete: :restrict
  add_foreign_key "rooms", "products", name: "fk_rooms_products", on_delete: :cascade
  add_foreign_key "step_completed", "quests", name: "fk_steps_completed_quests"
  add_foreign_key "step_completed", "steps", name: "fk_steps_completed_steps"
  add_foreign_key "steps", "quests", name: "fk_steps_quests"
  add_foreign_key "steps", "rewards", name: "fk_steps_rewards"
  add_foreign_key "trivia_answers", "people", name: "trivia_answers_person_id_fkey"
  add_foreign_key "trivia_answers", "products", name: "fk_trivia_answers_products", on_delete: :cascade
  add_foreign_key "trivia_answers", "trivia_questions", name: "trivia_answers_questions_id_fkey"
  add_foreign_key "trivia_available_answers", "products", name: "fk_trivia_available_answers_products", on_delete: :cascade
  add_foreign_key "trivia_available_answers", "trivia_available_questions", column: "trivia_question_id"
  add_foreign_key "trivia_available_questions", "products", name: "fk_trivia_available_questions_products", on_delete: :cascade
  add_foreign_key "trivia_available_questions", "trivia_topics", column: "topic_id"
  add_foreign_key "trivia_game_leaderboards", "people"
  add_foreign_key "trivia_game_leaderboards", "products", name: "fk_trivia_game_leaderboards_products", on_delete: :cascade
  add_foreign_key "trivia_game_leaderboards", "trivia_games"
  add_foreign_key "trivia_games", "products"
  add_foreign_key "trivia_games", "rooms"
  add_foreign_key "trivia_picture_available_answers", "products", name: "fk_trivia_picture_available_answers_products", on_delete: :cascade
  add_foreign_key "trivia_picture_available_answers", "trivia_available_questions", column: "question_id"
  add_foreign_key "trivia_prizes", "products", name: "fk_trivia_prizes_products", on_delete: :cascade
  add_foreign_key "trivia_prizes", "trivia_games"
  add_foreign_key "trivia_question_leaderboards", "people"
  add_foreign_key "trivia_question_leaderboards", "products", name: "fk_trivia_question_leaderboards_products", on_delete: :cascade
  add_foreign_key "trivia_question_leaderboards", "trivia_questions"
  add_foreign_key "trivia_questions", "products", name: "fk_trivia_questions_products", on_delete: :cascade
  add_foreign_key "trivia_questions", "trivia_available_questions", column: "available_question_id"
  add_foreign_key "trivia_questions", "trivia_rounds"
  add_foreign_key "trivia_round_leaderboards", "people"
  add_foreign_key "trivia_round_leaderboards", "products", name: "fk_trivia_round_leaderboards_products", on_delete: :cascade
  add_foreign_key "trivia_round_leaderboards", "trivia_rounds"
  add_foreign_key "trivia_rounds", "products", name: "fk_trivia_rounds_products", on_delete: :cascade
  add_foreign_key "trivia_rounds", "trivia_games"
  add_foreign_key "trivia_subscribers", "people"
  add_foreign_key "trivia_subscribers", "products", name: "fk_trivia_subscribers_products", on_delete: :cascade
  add_foreign_key "trivia_subscribers", "trivia_games"
  add_foreign_key "trivia_topics", "products", name: "fk_trivia_topics_products", on_delete: :cascade
  add_foreign_key "video_pages", "certcourse_pages", name: "fk_video_pages_certcourse_page"
  add_foreign_key "video_pages", "products", name: "fk_video_products", on_delete: :cascade
end
