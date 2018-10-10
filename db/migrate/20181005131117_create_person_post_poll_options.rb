class CreatePersonPostPollOptions < ActiveRecord::Migration[5.1]
  def change
  	create_table :person_post_poll_options do |t|
      t.integer :person_id, null: false
      t.integer :post_poll_option_id, null: false

      t.timestamps null: false
    end
  end
end
