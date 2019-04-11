class RenamePackageLeaderboardToQuestionPackageLeaderboard < ActiveRecord::Migration[5.1]
  def change
    rename_table :trivia_package_leaderboards, :trivia_question_package_leaderboards
  end
end
