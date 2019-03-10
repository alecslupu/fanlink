class RemoveTables < ActiveRecord::Migration[5.1]

  def up
    drop_table :image_pages
    drop_table :video_pages
    drop_table :quiz_pages
  end

  def down
    create_table "image_pages", force: :cascade do |t|
      t.integer "certcourse_page_id"
      t.datetime "created_at", null: false
      t.datetime "updated_at", null: false
      t.string "image_file_name"
      t.string "image_content_type"
      t.integer "image_file_size"
      t.datetime "image_updated_at"
      t.index ["certcourse_page_id"], name: "idx_image_pages_certcourse_page"
    end

    create_table "video_pages", force: :cascade do |t|
      t.integer "certcourse_page_id"
      t.datetime "created_at", null: false
      t.datetime "updated_at", null: false
      t.string "video_file_name"
      t.string "video_content_type"
      t.integer "video_file_size"
      t.datetime "video_updated_at"
      t.index ["certcourse_page_id"], name: "idx_video_pages_certcourse_page"
    end

    create_table "quiz_pages", force: :cascade do |t|
      t.integer "certcourse_page_id"
      t.boolean "is_optional", default: false
      t.string "quiz_text", default: "", null: false
      t.integer "wrong_answer_page_id"
      t.datetime "created_at", null: false
      t.datetime "updated_at", null: false
      t.index ["certcourse_page_id"], name: "idx_quiz_pages_certcourse_page"
    end

    add_foreign_key "image_pages", "certcourse_pages", name: "fk_image_pages_certcourse_page"
    add_foreign_key "video_pages", "certcourse_pages", name: "fk_video_pages_certcourse_page"
    add_foreign_key "quiz_pages", "certcourse_pages", name: "fk_quiz_pages_certcourse_page"

  end
end
