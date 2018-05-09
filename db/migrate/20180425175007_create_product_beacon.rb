class CreateProductBeacon < ActiveRecord::Migration[5.1]
  def change
    create_table :product_beacons do |t|
      t.integer :product_id, null: false
      t.text :beacon_pid, null: false
      t.integer :attached_to
      t.boolean :deleted, default: false
      t.timestamps null: false
    end
    add_index :product_beacons, [:product_id], name: "ind_beacons_products"
    add_index :product_beacons, [:beacon_pid], name: "ind_beacons_pid"
    add_foreign_key :product_beacons, :products, name: "fk_beacons_products"
  end
end