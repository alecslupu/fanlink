class SetStepToUnNullableInQuestActivity < ActiveRecord::Migration[5.1]
  def change
    QuestActivity.all.each do |qa|
      unless qa.step.nil?
        qa.step = 0
      end
    end
    change_column_null :quest_activities, :step, false
  end
end
