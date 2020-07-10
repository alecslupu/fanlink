class RemoveOldTaggings < ActiveRecord::Migration[5.2]
  def up
    drop_table :post_tags
    drop_table :old_tags
  end

  def down
    create_table "post_tags", id: false, force: :cascade do |t|
      t.bigint "post_id", null: false
      t.bigint "tag_id", null: false
      t.index ["post_id", "tag_id"], name: "index_post_tags_on_post_id_and_tag_id"
      t.index ["tag_id", "post_id"], name: "index_post_tags_on_tag_id_and_post_id"
    end

    create_table "old_tags", force: :cascade do |t|
      t.text "name", null: false
      t.integer "product_id", null: false
      t.datetime "created_at", null: false
      t.datetime "updated_at", null: false
      t.boolean "deleted", default: false, null: false
      t.integer "posts_count", default: 0
      t.index ["name"], name: "idx_tag_names"
      t.index ["product_id"], name: "idx_tag_products"
    end
  end
end
