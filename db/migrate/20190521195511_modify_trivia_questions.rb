class ModifyTriviaQuestions < ActiveRecord::Migration[5.1]
  def up
    remove_column :trivia_questions, :status
    remove_column :trivia_questions, :title
    add_column :trivia_questions, :available_question_id, :integer
    add_foreign_key :trivia_questions, :trivia_available_questions, column: :available_question_id
  end

  def down
    add_column :trivia_questions, :status, :integer, default: 0
    add_column :trivia_questions, :title, :string
    remove_foreign_key :trivia_questions, :trivia_available_questions
    remove_column :trivia_questions, :available_question_id
  end
end
