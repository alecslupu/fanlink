class ChangeStatusToIntInQuestCompletions < ActiveRecord::Migration[5.1]
  def change
    rename_column :quest_completions, :status, :status_old
    add_column :quest_completions, :status, :integer, default: 0, null: false
  end
end
