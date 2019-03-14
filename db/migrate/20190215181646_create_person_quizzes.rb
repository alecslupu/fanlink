class CreatePersonQuizzes < ActiveRecord::Migration[5.1]
  def change
  	create_table :person_quizzes do |t|
  	  t.integer :person_id, null: false
  	  t.integer :quiz_page_id, null: false
  	  t.integer :answer_id
  	  t.string :fill_in_response

      t.timestamps
    end
    add_index :person_quizzes, %i[ person_id ], name: "idx_person_quiz_pages_person"
    add_foreign_key :person_quizzes, :people, name: "fk_person_quiz_pages_person"
    add_index :person_quizzes, %i[ quiz_page_id ], name: "idx_person_quiz_pages_quiz_page_id"
    add_foreign_key :person_quizzes, :quiz_pages, name: "fk_person_quiz_pages_quiz_page_id"
  end
end
