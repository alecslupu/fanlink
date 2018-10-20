class CreatePersonPollOptions < ActiveRecord::Migration[5.1]
  def change
  	create_table :person_poll_options do |t|
      t.integer :person_id, null: false
      t.integer :poll_option_id, null: false

      t.timestamps null: false
    end
    add_index :person_poll_options, %i[ person_id ], name: "idx_person_poll_options_person"
    add_foreign_key :person_poll_options, :people, name: "fk_person_poll_options_person"
    add_index :person_poll_options, %i[ poll_option_id ], name: "idx_person_poll_options_poll_option"
    add_foreign_key :person_poll_options, :poll_options, name: "fk_person_poll_options_poll_option"
  end
end
