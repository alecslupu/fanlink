class RenameQuestCompletedsTable < ActiveRecord::Migration[5.1]
  def change
    rename_table :quest_completeds, :quest_completed
  end
end
