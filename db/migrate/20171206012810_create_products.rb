class CreateProducts < ActiveRecord::Migration[5.1]
  def change
    create_table :products do |t|
      t.text :name, null: false
      t.text :subdomain, null: false
      t.boolean :enabled, default: false, null: false
      t.timestamps null: false
    end
    add_index :products, [ :name ], name: "unq_products_name", unique: true
    add_index :products, [ :subdomain ], name: "unq_products_subdomain", unique: true
  end
end
