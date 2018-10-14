class CreatePostPollOptions < ActiveRecord::Migration[5.1]
  def change
    create_table :post_poll_options do |t|
      t.text :description, null: false
      t.integer :post_poll_id, null: false
      t.timestamps
    end
    #add_index :post_poll_post_poll_options, %i[ post_poll_id ], name: "idx_person_post_poll_options_person"
    #add_foreign_key :post_poll_post_poll_options, :post_polls, name: "idx_post_poll_post_poll_options_person"
  end
end
