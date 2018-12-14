class CreateQuestCompleted < ActiveRecord::Migration[5.1]
  def change
    create_table :quest_completeds do |t|
      t.integer :quest_id, null: false
      t.integer :person_id, null: false
      t.timestamps null: false
    end
    add_foreign_key :quest_completeds, :people, name: "fk_quest_completeds_people"
    add_foreign_key :quest_completeds, :quests, name: "fk_quest_completeds_quests"
  end
end
