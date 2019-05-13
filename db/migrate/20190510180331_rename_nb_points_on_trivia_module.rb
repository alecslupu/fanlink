class RenameNbPointsOnTriviaModule < ActiveRecord::Migration[5.1]
  def change
    rename_column :trivia_question_leaderboards, :nb_points, :points
    rename_column :trivia_round_leaderboards, :nb_points, :points
    rename_column :trivia_game_leaderboards, :nb_points, :points
  end
end
