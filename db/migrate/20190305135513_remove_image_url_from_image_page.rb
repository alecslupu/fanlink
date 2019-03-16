class RemoveImageUrlFromImagePage < ActiveRecord::Migration[5.1]
  def up
  	remove_column :image_pages, :image_url
  end

  def down
  	add_column :image_pages, :image_url, :string
  end
end
