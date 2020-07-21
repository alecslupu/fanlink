class RenameImagePageToCoursewareImagePage < ActiveRecord::Migration[6.0]
  def change
    rename_table :image_pages, :courseware_image_pages
    rename_column :courseware_image_pages, :certcourse_page_id, :course_page_id
  end
end
