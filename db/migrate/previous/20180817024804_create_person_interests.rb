class CreatePersonInterests < ActiveRecord::Migration[5.1]
  def change
    create_table :person_interests do |t|
      t.integer :person_id, null: false
      t.integer :interest_id, null: false
    end
    add_index :person_interests, %i[ person_id ], name: "idx_person_interests_person"
    add_foreign_key :person_interests, :people, name: "fk_person_interests_person"
    add_index :person_interests, %i[ interest_id ], name: "idx_person_interests_interest"
    add_foreign_key :person_interests, :interests, name: "fk_person_interests_interest"
  end
end
