class RenameQuestPersonCompletionToQuestCompletion < ActiveRecord::Migration[5.1]
  def change
    rename_table :quest_person_completions, :quest_completions
  end
end
