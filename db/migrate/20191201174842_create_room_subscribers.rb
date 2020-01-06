class CreateRoomSubscribers < ActiveRecord::Migration[5.1]
  def up
    create_table :room_subscribers do |t|
      t.references :room, foreign_key: true
      t.references :person, foreign_key: true
      t.references :last_message, index: true, foreign_key: { to_table: :messages,  }
      t.datetime :last_notification_time

      t.timestamps
    end
  end

  def down
    drop_table :room_subscribers
  end
end
