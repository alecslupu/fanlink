class ChangeTriviaCooldownDefault < ActiveRecord::Migration[5.1]
  def up

    change_column_default :trivia_available_questions, :cooldown_period, 6
    change_column_default :trivia_available_questions, :time_limit, 30
    change_column_default :trivia_questions, :cooldown_period, 6
    change_column_default :trivia_questions, :time_limit, 30
  end

  def down
    change_column_default :trivia_available_questions, :cooldown_period, 30
    change_column_default :trivia_available_questions, :time_limit, 6
    change_column_default :trivia_questions, :cooldown_period, 30
    change_column_default :trivia_questions, :time_limit, 6
  end
end
