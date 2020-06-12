class CreateBadgeActions < ActiveRecord::Migration[5.1]
  def up
    create_table :badge_actions do |t|
      t.integer :action_type_id, null: false
      t.integer :person_id, null: false
      t.timestamps null: false
    end
    add_index :badge_actions, %i[ action_type_id person_id ], name: "ind_badge_actions_action_type_person"

    add_column :badge_actions, :identifier, :text
    add_index(:badge_actions, %i[ person_id action_type_id identifier ],
              unique: true,
              name: "unq_badge_action_person_action_type_identifier",
              where: "identifier is NOT NULL")
  end

  def down
    drop_table :badge_actions
  end
end
