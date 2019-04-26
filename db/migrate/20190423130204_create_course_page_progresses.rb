class CreateCoursePageProgresses < ActiveRecord::Migration[5.1]
  def change
    create_table :course_page_progresses do |t|
      t.boolean :passed, default: false
      t.belongs_to :certcourse_page
      t.belongs_to :person

      t.timestamps
    end
  end
end
