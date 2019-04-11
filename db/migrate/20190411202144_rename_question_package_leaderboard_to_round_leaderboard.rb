class RenameQuestionPackageLeaderboardToRoundLeaderboard < ActiveRecord::Migration[5.1]
  def change
    rename_table :question_package_leaderboards, :round_leaderboards
  end
end
