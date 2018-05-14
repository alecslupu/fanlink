class ChangeBeaconToIntegerInQuestActivities < ActiveRecord::Migration[5.1]
  def change
    reversible do |dir|
      dir.up do
        change_column :quest_activities, :beacon, 'integer USING CAST(beacon AS integer)', unique: true
      end
      dir.down do
        change_column :quest_activities, :beacon, 'text USING CAST(beacon AS text)', unique: false
      end
    end

    QuestActivity.all.each do |qa|
      unless qa.beacon.is_a? Numeric
        qa.beacon = qa.id
      end
    end
  end
end
