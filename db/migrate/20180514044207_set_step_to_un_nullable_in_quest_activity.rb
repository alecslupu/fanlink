class SetStepToUnNullableInQuestActivity < ActiveRecord::Migration[5.1]
  def change
    change_column_null :quest_activities, :step, false
    QuestActivity.all.each do |qa|
      unless qa.step.nil?
        qa.step = 0
      end
    end
  end
end
