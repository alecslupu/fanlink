class RenamePersonCertcoursesCoursewarePersonCourses < ActiveRecord::Migration[6.0]
  def change
    rename_table :person_certcourses, :courseware_person_courses
  end
end
