class RenameVideoPageToCoursewareVideoPage < ActiveRecord::Migration[6.0]
  def change
    rename_table :video_pages, :courseware_video_pages
    rename_column :courseware_video_pages, :certcourse_page_id, :course_page_id
  end
end
