class AddProductIdToPersonCertcourses < ActiveRecord::Migration[6.0]
  class PersonCertcourse < ApplicationRecord
    self.table_name = :courseware_person_courses
    belongs_to :person
  end

  def up
    add_column :courseware_person_courses, :product_id, :integer
    add_foreign_key :courseware_person_courses, :products, column: :product_id

    rename_column :courseware_person_courses, :certcourse_id, :course_id

    PersonCertcourse.find_each do |pc|
      PersonCertcourse.where(id: pc.id).update_all(product_id: pc.person.product_id)
    end
  end

  def down
    raise ActiveRecord::IrreversibleMigration
  end
end
