class RenameCoursePageProgressesToCoursewarePersonCoursePageProgresses < ActiveRecord::Migration[6.0]


  class CoursePageProgress < ApplicationRecord
    self.table_name = :courseware_person_course_page_progresses
    belongs_to :person
  end


  def up
    rename_index :course_page_progresses, :index_course_page_progresses_on_certcourse_page_id, :idx_person_course_page_progresses_on_course_page_id
    rename_index :course_page_progresses, :index_course_page_progresses_on_person_id, :idx_person_course_page_progresses_on_person_id

    rename_table :course_page_progresses, :courseware_person_course_page_progresses
    rename_column :courseware_person_course_page_progresses, :certcourse_page_id, :course_id
    add_column :courseware_person_course_page_progresses, :product_id, :integer
    add_foreign_key :courseware_person_course_page_progresses, :products, column: :product_id,  index: { name: :idx_person_course_page_progresses_on_product_id }

    CoursePageProgress.includes(:person).find_each do |pc|
      CoursePageProgress.where(id: pc.id).update_all(product_id: pc.person.product_id)
    end
  end

  def down
    raise ActiveRecord::IrreversibleMigration
  end
end
