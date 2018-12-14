class CreateRoomMemberships < ActiveRecord::Migration[5.1]
  def change
    create_table :room_memberships do |t|
      t.integer :room_id, null: false
      t.integer :person_id, null: false
      t.timestamps
    end
    add_index :room_memberships, %i[ room_id person_id ], name: "unq_room_memberships_room_person", unique: true
    add_index :room_memberships, %i[ person_id ], name: "idx_room_memberships_person"
    add_foreign_key :room_memberships, :rooms, name: "fk_room_memberships_rooms", on_delete: :cascade
    add_foreign_key :room_memberships, :people, name: "fk_room_memberships_people", on_delete: :cascade
  end
end
