class CreatePostPolls < ActiveRecord::Migration[5.1]
  def change
  	create_table :post_polls do |t|
      t.integer :post_id, null: false
      t.integer :poll_id, null: false

      t.timestamps null: false
    end
    add_index :post_polls, %i[ post_id ], name: "idx_post_polls_post"
    #add_foreign_key :post_polls, name: "fk_post_polls_post"
    add_index :post_polls, %i[ poll_id ], name: "idx_post_polls_poll"
    #add_foreign_key :post_polls, name: "fk_post_polls_poll"
    #add_index :person_post_poll_options, %i[ person_id ], name: "idx_person_post_poll_options_person"
    #add_foreign_key :person_post_poll_options, :people, name: "fk_person_post_poll_options_person"
    #add_index :person_post_poll_options, %i[ post_poll_option_id ], name: "idx_person_post_poll_options_post_poll_option"
    #add_foreign_key :person_post_poll_options, :post_poll_options, name: "fk_person_post_poll_options_post_poll_option"
  end
end
