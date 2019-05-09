class CreateTriviaAnswers < ActiveRecord::Migration[5.1]
  def change
    create_table :trivia_answers do |t|
      t.belongs_to :person, foreign_key: true
      t.belongs_to :trivia_question, foreign_key: true
      t.string :answered
      t.integer :time
      t.boolean :is_correct, default: false

      t.timestamps
    end
  end
end
