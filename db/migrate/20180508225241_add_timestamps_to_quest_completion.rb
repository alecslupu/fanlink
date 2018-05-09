class AddTimestampsToQuestCompletion < ActiveRecord::Migration[5.1]
  def change
    change_table(:quest_completions) { |t| t.timestamps }
  end
end
