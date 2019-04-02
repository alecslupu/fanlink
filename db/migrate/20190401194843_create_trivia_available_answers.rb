class CreateTriviaAvailableAnswers < ActiveRecord::Migration[5.1]
  def change
    create_table :trivia_available_answers do |t|
      t.belongs_to :trivia_question, foreign_key: true
      t.string :name
      t.string :hint
      t.boolean :is_correct, null: false, default: false
      t.integer :status, default: 0, null: false

      t.timestamps
    end
  end
end
