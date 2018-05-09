class AddIndexForQuestIdToQuestCompletion < ActiveRecord::Migration[5.1]
  def change
    add_index :quest_completions, [:person_id], name: "ind_quest_person_completions"
    add_index :quest_completions, [:quest_id], name: "ind_quest_completions"
  end
end
