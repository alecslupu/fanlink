class ChangeTriviaAvailableAnswers < ActiveRecord::Migration[5.1]
  def up
    truncate :trivia_available_answers
    remove_foreign_key :trivia_available_answers, :trivia_questions
    add_foreign_key :trivia_available_answers, :trivia_available_questions, column: :trivia_question_id
  end
  def down
    truncate :trivia_available_answers
    remove_foreign_key :trivia_available_answers, :trivia_available_questions
    add_foreign_key :trivia_available_answers, :trivia_questions, column: :trivia_question_id
  end
end
