class SetStepToUnNullableInQuestActivity < ActiveRecord::Migration[5.1]
  def change
    change_column_null :quest_activities, :step, false
  end
end
