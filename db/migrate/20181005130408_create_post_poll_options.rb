class CreatePostPollOptions < ActiveRecord::Migration[5.1]
  def change
    create_table :post_poll_options do |t|
      t.text :description, null: false
      t.integer :post_poll_id, null: false
      t.timestamps
    end
    add_foreign_key :post_poll_options, :post_polls
  end
end
