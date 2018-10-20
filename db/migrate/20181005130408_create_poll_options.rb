class CreatePollOptions < ActiveRecord::Migration[5.1]
  def change
    create_table :poll_options do |t|
      t.text :description, null: false
      t.integer :poll_id, null: false
      t.timestamps
    end
    add_index :poll_options, %i[ poll_id ], name: "idx_poll_options_poll"
    add_foreign_key :poll_options, :polls, name: "idx_poll_options_poll"
  end
end
