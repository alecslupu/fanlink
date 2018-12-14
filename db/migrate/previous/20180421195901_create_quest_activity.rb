class CreateQuestActivity < ActiveRecord::Migration[5.1]
  def change
    create_table :quest_activities do |t|
      t.integer :quest_id, null: false
      t.text :description
      t.text :hint
      t.boolean :post
      t.boolean :image
      t.boolean :audio
      t.text :requires
      t.boolean :deleted, default: false
    end
    add_index :quest_activities, [:quest_id], name: "ind_activity_quest"
    add_foreign_key :quest_activities, :quests, name: "fk_activities_quests"
  end
end



