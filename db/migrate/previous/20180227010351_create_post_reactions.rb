class CreatePostReactions < ActiveRecord::Migration[5.1]
  def change
    create_table :post_reactions do |t|
      t.integer :post_id, null: false
      t.integer :person_id, null: false
      t.text :reaction, null: false
    end
    add_index :post_reactions, %i[ post_id ], name: "idx_post_reactions_post"
    add_index :post_reactions, %i[ post_id person_id ], unique: true, name: "unq_post_reactions_post_person"
    add_foreign_key :post_reactions, :posts, name: "fk_post_reactions_post", on_delete: :cascade
    add_foreign_key :post_reactions, :people, name: "fk_post_reactions_people", on_delete: :cascade
  end
end
