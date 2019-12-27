class CreateRoomOwners < ActiveRecord::Migration[5.1]
  def change
    create_table :rooms_owners do |t|
      t.integer :person_id
      t.integer :room_id
      t.index :person_id
      t.index :room_id
    end
  end
end
