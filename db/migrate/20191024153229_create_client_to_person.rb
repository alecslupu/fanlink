class CreateClientToPerson < ActiveRecord::Migration[5.1]
  def self.up
    unless table_exists? :client_to_people
      create_table :client_to_people do |t|
        t.integer :relation_type, null: false
        t.integer :status, null: false
        t.integer :client_id, null: false
        t.integer :person_id, null: false

        t.timestamps
      end
      add_index :client_to_people, :client_id
    end
  end
  def self.down
    drop_table :client_to_people
  end
end
