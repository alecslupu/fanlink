class RemoveQuestIdFromQuestCompletions < ActiveRecord::Migration[5.1]
  def change
    remove_column :quest_completion, :quest_id
  end
end
