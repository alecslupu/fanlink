class AddCaptionToDownloadFilePage < ActiveRecord::Migration[5.1]
  def change
    add_column :download_file_pages, :caption, :text
  end
end
