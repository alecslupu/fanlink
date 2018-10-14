class CreatePolls < ActiveRecord::Migration[5.1]
  def change
    create_table :polls do |t|
      #t.integer :post_id, null: false
      t.text :description, null: false
      t.datetime :start_date
      t.time :duration
      t.string :poll_status

      t.timestamps
    end
    #add_index :post_polls, %i[ post_id ], name: "idx_post_polls_post"
    #add_foreign_key :post_polls, :posts, name: "fk_post_polls_post", on_delete: :cascade
  end
end
