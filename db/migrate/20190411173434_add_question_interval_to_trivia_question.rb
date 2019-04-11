class AddQuestionIntervalToTriviaQuestion < ActiveRecord::Migration[5.1]
  def change
    add_column :trivia_questions, :question_interval, :integer, default: 5
  end
end
