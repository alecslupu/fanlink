class CreatePostComments < ActiveRecord::Migration[5.1]
  def change
    create_table :post_comments do |t|
      t.integer :post_id, null: false
      t.integer :person_id, null: false
      t.text :body, null: false
      t.boolean :hidden, default: false, null: false
      t.timestamps null: false
    end
    add_index :post_comments, %i[ post_id ], name: "idx_post_comments_post"
    add_foreign_key :post_comments, :posts, name: "fk_post_comments_post", on_delete: :cascade
    add_foreign_key :post_comments, :people, name: "fk_post_comments_people", on_delete: :cascade
  end
end
