class CreateActivityType < ActiveRecord::Migration[5.1]
  def change
    create_table :activity_types do |t|
      t.integer :activity_id, null: false
      t.text :type, null: false
      t.jsonb :value, null: false
    end
    add_index :activity_types, :activity_id, name: "ind_activity_id"
    add_foreign_key :activity_types, :quest_activities, column: "activity_id", name: "fk_activity_types_quest_activities"
  end
end
