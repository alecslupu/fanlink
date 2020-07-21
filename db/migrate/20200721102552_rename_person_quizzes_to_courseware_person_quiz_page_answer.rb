class RenamePersonQuizzesToCoursewarePersonQuizPageAnswer < ActiveRecord::Migration[6.0]
  class PersonQuiz < ApplicationRecord
    self.table_name = :courseware_person_quiz_page_answers
    belongs_to :person
  end

  def up
    rename_table :person_quizzes, :courseware_person_quiz_page_answers
    add_column :courseware_person_quiz_page_answers, :product_id, :integer
    add_foreign_key :courseware_person_quiz_page_answers, :products,  column: :product_id

    PersonQuiz.includes(:person).find_each do |pc|
      PersonQuiz.where(id: pc.id).update_all(product_id: pc.person.product_id)
    end
  end

  def down
    raise ActiveRecord::IrreversibleMigration
  end
end
