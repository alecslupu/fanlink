class CreateInterests < ActiveRecord::Migration[5.1]
  def change
    create_table :interests do |t|
      t.integer :product_id, null: false
      t.integer :parent_id, null: true
      t.jsonb :title, default: {}, null: false
      t.timestamps null: false
    end
  add_index :interests, %i[ product_id ], name: "idx_interests_product"
  add_foreign_key :interests, :products, name: "fk_interests_products"
  add_index :interests, %i[ parent_id ], name: "idx_interests_parent"
  end
end
