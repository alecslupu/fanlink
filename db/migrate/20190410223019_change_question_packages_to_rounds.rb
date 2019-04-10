class ChangeQuestionPackagesToRounds < ActiveRecord::Migration[5.1]
  def change
    rename_table :trivia_question_packages, :trivia_rounds

  end
end
