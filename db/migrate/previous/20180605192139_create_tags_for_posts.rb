class CreateTagsForPosts < ActiveRecord::Migration[5.1]
  def change
    create_table :tags do |t|
      t.text :name, null: false
      t.integer :product_id, null: false
      t.timestamps null: false
      t.boolean :deleted, default: false, null: false
    end
    add_index :tags, :name, name: "idx_tag_names"
    add_index :tags, :product_id, name: "idx_tag_products"
  end
end
