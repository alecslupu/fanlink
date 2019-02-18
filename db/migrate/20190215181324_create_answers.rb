class CreateAnswers < ActiveRecord::Migration[5.1]
  def change
    create_table :answers do |t|
      t.references :quiz_page, foreign_key: true
      t.string :description, default: "", null: false
      t.boolean :is_correct, default: false

      t.timestamps
    end
    add_index :answers, %i[ quiz_page ], name: "idx_answers_quiz_page"
  end
end
