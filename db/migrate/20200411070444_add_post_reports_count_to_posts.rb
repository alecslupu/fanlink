class AddPostReportsCountToPosts < ActiveRecord::Migration[5.2]
  def up
    unless column_exists?(:posts, :post_reports_count)
      add_column :posts, :post_reports_count, :integer, default: 0
    end
    Post.reset_column_information

    Post.find_each do |post|
      Post.reset_counters(post.id, :post_reports)
    end
  end
  def down
    if column_exists?( :posts, :post_reports_count)
      remove_column :posts, :post_reports_count
    end
  end
end
