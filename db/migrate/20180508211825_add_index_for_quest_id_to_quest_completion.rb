class AddIndexForQuestIdToQuestCompletion < ActiveRecord::Migration[5.1]
  def change
    add_index :quest_completions, [:quest_id], name: "ind_quest_completions"
  end
end
