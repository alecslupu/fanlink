class AddIndexToClientToPeople < ActiveRecord::Migration[5.1]
  def change
    add_index :client_to_people, [:client_id, :person_id], name: "unq_client_person_pair", unique: true
  end
end
