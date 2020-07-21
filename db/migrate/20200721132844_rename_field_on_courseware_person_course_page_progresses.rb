class RenameFieldOnCoursewarePersonCoursePageProgresses < ActiveRecord::Migration[6.0]
  def change
    rename_column :courseware_person_course_page_progresses, :course_id, :course_page_id
  end
end
