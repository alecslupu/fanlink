class CreateRooms < ActiveRecord::Migration[5.1]
  def change
    create_table :rooms do |t|
      t.integer :product_id, null: false
      t.text :name, null: false
      t.text :name_canonical, null: false
      t.integer :created_by_id, null: false
      t.integer :status, default: 0, null: false
      t.boolean :public, default: false, null: false
      t.text :picture_id
    end
    add_index :rooms, [:product_id, :status], name: "unq_rooms_product_status"
    add_foreign_key :rooms, :products, name: "fk_rooms_products", on_delete: :cascade
    add_foreign_key :rooms, :people, column: :created_by_id, name: "fk_rooms_created_by", on_delete: :restrict
  end
end
