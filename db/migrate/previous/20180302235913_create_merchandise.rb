class CreateMerchandise < ActiveRecord::Migration[5.1]
  def change
    create_table :merchandise do |t|
      t.integer :product_id, null: false
      t.text :name, null: false
      t.text :description
      t.text :price
      t.text :purchase_url
      t.string :picture_file_name
      t.string :picture_content_type
      t.integer :picture_file_size
      t.datetime :picture_updated_at
      t.timestamps null: false
    end
    add_index :merchandise, %i[ product_id ], name: "idx_merchandise_product"
    add_foreign_key :merchandise, :products, name: "fk_merchandise_products"
  end
end
