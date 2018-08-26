class CreateEventCheckin < ActiveRecord::Migration[5.1]
  def change
    create_table :event_checkins do |t|
      t.integer :event_id, null: false
      t.integer :person_id, null: false
      t.timestamps null: false
    end
    add_index :event_checkins, %i[ person_id ], name: "idx_event_checkins_person"
    add_foreign_key :person_interests, :people, name: "fk_event_checkins_person"
    add_index :event_checkins, %i[ event_id ], name: "idx_event_checkins_event"
    add_foreign_key :event_checkins, :events, name: "fk_event_checkins_event"
  end
end
