class AddStatusToQuestCompletion < ActiveRecord::Migration[5.1]
  def change
    add_column :quest_completions, :status, :text, :default => 0, null: false
    QuestCompletion.update_all(:status => 2)
  end
end
