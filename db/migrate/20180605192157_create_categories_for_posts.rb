class CreateCategoriesForPosts < ActiveRecord::Migration[5.1]
  def change
    create_table :categories do |t|
    t.text :name, null: false
    t.integer :product_id, null: false
    t.integer :role, default: 0, null: false
    t.text :color, default: nil
    t.timestamps null: false
    t.boolean :deleted, default: false, null: false
    end
    add_index :categories, :name, name: "idx_category_names" 
    add_index :categories, :role, name: "idx_category_roles" 
  end
end
