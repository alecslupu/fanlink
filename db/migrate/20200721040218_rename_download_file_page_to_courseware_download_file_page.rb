class RenameDownloadFilePageToCoursewareDownloadFilePage < ActiveRecord::Migration[6.0]
  def change
    rename_table :download_file_pages, :courseware_download_file_pages
    rename_column :courseware_download_file_pages, :certcourse_page_id, :course_page_id
  end
end
