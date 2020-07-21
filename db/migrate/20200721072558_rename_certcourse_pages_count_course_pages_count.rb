class RenameCertcoursePagesCountCoursePagesCount < ActiveRecord::Migration[6.0]
  def change
    rename_column :courseware_courses, :certcourse_pages_count,:course_pages_count
  end
end
