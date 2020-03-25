class AddIndexOnRoomSubscribersUniqueness < ActiveRecord::Migration[5.1]
  def up
    add_index :room_subscribers, %i[ room_id person_id ], name: "unq_room_person", unique: true
  end

  def down
    remove_index :room_subscribers, name: "unq_room_person"
  end
end
