class AddPostReportsCountToPosts < ActiveRecord::Migration[5.2]
  def up
    add_column :posts, :post_reports_count, :integer, default: 0
    Post.reset_column_information

    Post.find_each do |post|
      Post.reset_counters(post.id, :post_reports)
    end
  end
  def down
    remove_column :posts, :post_reports_count
  end
end
