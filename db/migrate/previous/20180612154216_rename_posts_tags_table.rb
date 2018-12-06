class RenamePostsTagsTable < ActiveRecord::Migration[5.1]
  def change
    rename_table :posts_tags, :post_tags
  end
end
