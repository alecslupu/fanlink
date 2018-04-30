class CreateQuestPersonCompletion < ActiveRecord::Migration[5.1]
  def change
    create_table :quest_person_completions do |t|
      t.integer :person_id, null: false
      t.integer :quest_id, null: false
      t.integer :activity_id
    end
    add_index :quest_person_completions, [:person_id], name: "ind_quest_person_completions"
  end
end
