class AddDeletedFieldsToSemesterCourseLesson < ActiveRecord::Migration[5.1]
  def change
    add_column :semesters, :deleted, :boolean, default: false
    add_column :courses, :deleted, :boolean, default: false
    add_column :lessons, :deleted, :boolean, default: false
  end
end
