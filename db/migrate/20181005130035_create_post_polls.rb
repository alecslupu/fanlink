class CreatePostPolls < ActiveRecord::Migration[5.1]
  def change
    create_table :post_polls do |t|
      t.integer :post_id, null: false
      t.text :description, null: false

      t.timestamps
    end
    add_index :post_polls, %i[ post_id ], name: "idx_post_polls_post"
    add_foreign_key :post_polls, :posts, name: "fk_post_polls_post", on_delete: :cascade
  end
end
