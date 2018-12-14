class CreatePinMessage < ActiveRecord::Migration[5.1]
  def change
    create_table :pin_messages do |t|
      t.integer :person_id, null: false
      t.integer :room_id, null: false
      t.timestamps
    end
  end
end
