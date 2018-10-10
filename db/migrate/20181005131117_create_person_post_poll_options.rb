class CreatePersonPostPollOptions < ActiveRecord::Migration[5.1]
  def change
  	create_table :person_post_poll_options do |t|
      t.integer :person_id, null: false
      t.integer :post_poll_option_id, null: false

      t.timestamps null: false
    end
    add_index :person_post_poll_options, %i[ person_id ], name: "idx_person_post_poll_options_person"
    add_foreign_key :person_post_poll_options, :people, name: "fk_person_post_poll_options_person"
    add_index :person_post_poll_options, %i[ post_poll_option_id ], name: "idx_person_post_poll_options_post_poll_option"
    add_foreign_key :person_post_poll_options, :post_poll_options, name: "fk_person_post_poll_options_post_poll_option"
  end
end
