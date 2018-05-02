class CreatePostCommentReports < ActiveRecord::Migration[5.1]
  def change
    create_table :post_comment_reports do |t|
      t.integer :post_comment_id, null: false
      t.integer :person_id, null: false
      t.text :reason
      t.integer :status, default: 0, null: false
      t.timestamps null: false
    end
    add_index :post_comment_reports, %i[ post_comment_id ], name: "idx_post_comment_reports_post_comment"
    add_foreign_key :post_comment_reports, :post_comments, name: "fk_post_comment_reports_post_comments", on_delete: :cascade
    add_foreign_key :post_comment_reports, :people, name: "fk_post__comment_reports_people", on_delete: :cascade
  end
end
