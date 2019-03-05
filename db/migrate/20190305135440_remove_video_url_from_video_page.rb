class RemoveVideoUrlFromVideoPage < ActiveRecord::Migration[5.1]
  def up
  	remove_column :video_pages, :video_url
  end

  def down
  	add_column :video_pages, :video_url, :string
  end
end
