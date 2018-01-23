class CreateBadgeActions < ActiveRecord::Migration[5.1]
  def change
    create_table :badge_actions do |t|
      t.integer :action_type_id, null: false
      t.integer :person_id, null: false
      t.timestamps null:false
    end
    add_index :badge_actions, %i[ action_type_id person_id ], name: "ind_badge_actions_action_type_person"
  end
end
