class CreatePostCommentMentions < ActiveRecord::Migration[5.1]
  def change
    create_table :post_comment_mentions do |t|
      t.integer :post_comment_id, null: false
      t.integer :person_id, null: false
      t.integer :location, default: 0, null: false
      t.integer :length, default: 0, null: false
    end
    add_index :post_comment_mentions, [:post_comment_id], name: "ind_post_comment_mentions_post_comments"
    add_foreign_key :post_comment_mentions, :post_comments, name: "fk_post_comment_mentions_post_comments", on_delete: :cascade
    add_foreign_key :post_comment_mentions, :people, name: "fk_post_comment_mentions_people", on_delete: :cascade
  end
end
