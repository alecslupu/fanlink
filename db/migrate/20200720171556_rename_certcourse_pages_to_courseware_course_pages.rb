class RenameCertcoursePagesToCoursewareCoursePages < ActiveRecord::Migration[6.0]
  def change
    rename_table :certcourse_pages, :courseware_course_pages
    rename_column :courseware_course_pages, :certcourse_id, :course_id
    rename_column :courseware_course_pages, :certcourse_page_order, :course_page_order
  end
end
