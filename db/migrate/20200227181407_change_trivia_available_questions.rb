class ChangeTriviaAvailableQuestions < ActiveRecord::Migration[5.1]
  def up
    change_column_default :trivia_available_questions, :cooldown_period, 30
    change_column_default :trivia_available_questions, :time_limit, 6
  end

  def down
    change_column_default :trivia_available_questions, :cooldown_period, nil
    change_column_default :trivia_available_questions, :time_limit, nil
  end
end
