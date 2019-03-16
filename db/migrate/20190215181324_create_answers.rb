class CreateAnswers < ActiveRecord::Migration[5.1]
  def change
    create_table :answers do |t|
      t.integer :quiz_page_id
      t.string :description, default: "", null: false
      t.boolean :is_correct, default: false

      t.timestamps
    end
    add_index :answers, %i[ quiz_page_id ], name: "idx_answers_quiz"
    add_foreign_key :answers, :quiz_pages, name: "fk_answers_quiz"
  end
end
