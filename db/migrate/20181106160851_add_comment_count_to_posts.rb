class AddCommentCountToPosts < ActiveRecord::Migration[5.1]
  def change
    add_column :posts, :post_comments_count, :integer, default: 0
  end
end
