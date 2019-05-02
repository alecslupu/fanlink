class ChangeTriviaModule < ActiveRecord::Migration[5.1]
  def self.up
    rename_column :trivia_questions, :question_interval, :cooldown_period
    remove_column :trivia_questions, :start_date
    add_column :trivia_questions, :start_date, :integer

    remove_column :trivia_questions, :end_date
    add_column :trivia_questions, :end_date, :integer

    remove_column :trivia_rounds, :start_date
    add_column :trivia_rounds, :start_date, :integer

    remove_column :trivia_rounds, :end_date
    add_column :trivia_rounds, :end_date, :integer

    remove_column :trivia_games, :start_date
    add_column :trivia_games, :start_date, :integer

    remove_column :trivia_games, :end_date
    add_column :trivia_games, :end_date, :integer

  end

  def self.down
    rename_column :trivia_questions, :cooldown_period, :question_interval
    remove_column :trivia_questions, :start_date
    add_column :trivia_questions, :start_date, :datetime

    remove_column :trivia_questions, :end_date
    add_column :trivia_questions, :end_date, :datetime

    remove_column :trivia_rounds, :start_date
    add_column :trivia_rounds, :start_date, :datetime

    remove_column :trivia_rounds, :end_date
    add_column :trivia_rounds, :end_date, :datetime

    remove_column :trivia_games, :start_date
    add_column :trivia_games, :start_date, :datetime

    remove_column :trivia_games, :end_date
    add_column :trivia_games, :end_date, :datetime
  end
end
