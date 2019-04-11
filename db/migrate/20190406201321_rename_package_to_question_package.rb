class RenamePackageToQuestionPackage < ActiveRecord::Migration[5.1]
  def change
    rename_table :trivia_packages, :trivia_question_packages
  end
end
