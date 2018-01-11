class CreatePosts < ActiveRecord::Migration[5.1]
  def change
    create_table :posts do |t|
      t.integer :person_id, null: false
      t.text :title
      t.text :body, null: false
      t.text :picture_id
      t.boolean :global, default: false, null: false
      t.datetime :starts_at
      t.datetime :ends_at
      t.integer :repost_interval, default: 0, null: false
      t.integer :status, default: 0, null: false
      t.timestamps null: false
    end
    add_index :posts, [:person_id], name: "idx_posts_person"
    add_foreign_key :posts, :people, name: "fk_posts_people", on_delete: :cascade
  end
end
