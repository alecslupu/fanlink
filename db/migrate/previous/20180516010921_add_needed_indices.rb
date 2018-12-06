class AddNeededIndices < ActiveRecord::Migration[5.1]
  def change
    add_index :messages, :created_at
    add_index :message_reports, :created_at
    add_index :message_reports, :status
    add_index :posts, :created_at
    add_index :post_reports, :created_at
    add_index :post_comments, :created_at
    add_index :post_comment_reports, :created_at
    add_index :people, :created_at
  end
end
