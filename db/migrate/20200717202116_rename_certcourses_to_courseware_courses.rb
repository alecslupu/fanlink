class RenameCertcoursesToCoursewareCourses < ActiveRecord::Migration[6.0]
  def change
    rename_table :certcourses, :courseware_courses
  end
end
