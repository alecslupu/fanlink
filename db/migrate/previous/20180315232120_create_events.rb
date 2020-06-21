class CreateEvents < ActiveRecord::Migration[5.1]
  def change
    create_table :events do |t|
      t.integer :product_id, null: false
      t.text :name, null: false
      t.text :description
      t.datetime :starts_at, null: false
      t.datetime :ends_at
      t.text :ticket_url
      t.text :place_identifier
      t.timestamps null: false
    end
    add_index :events, [:product_id], name: "ind_events_products"
    add_index :events, [:starts_at], name: "ind_events_starts_at"
    add_index :events, [:ends_at], name: "ind_events_ends_at"
    add_foreign_key :events, :products, name: "fk_events_products"
    add_column :events, :deleted, :boolean, default: false, null: false

  end
end
