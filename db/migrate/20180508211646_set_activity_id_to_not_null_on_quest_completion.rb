class SetActivityIdToNotNullOnQuestCompletion < ActiveRecord::Migration[5.1]
  def change
    change_column_null :quest_completions, :activity_id, false
  end
end
