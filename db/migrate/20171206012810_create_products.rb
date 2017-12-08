class CreateProducts < ActiveRecord::Migration[5.1]
  def change
    create_table :products do |t|
      t.text :name, null: false
      t.text :internal_name, null: false
      t.boolean :enabled, default: false, null: false
      t.timestamps null: false
    end
    add_index :products, [ :name ], name: "unq_products_name", unique: true
    add_index :products, [ :internal_name ], name: "unq_products_internal_name", unique: true
  end
end
