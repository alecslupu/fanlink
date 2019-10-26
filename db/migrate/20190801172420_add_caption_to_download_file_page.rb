class AddCaptionToDownloadFilePage < ActiveRecord::Migration[5.1]
  def up
    unless column_exists?(:download_file_pages, :caption)
      add_column :download_file_pages, :caption, :text
    end
  end
  def down
    remove_column :download_file_pages, :caption
  end
end
