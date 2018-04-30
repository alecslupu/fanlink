class CreateQuest < ActiveRecord::Migration[5.1]
  def change
    create_table :quests do |t|
      t.integer :product_id, null: false
      t.integer :event_id, null: true
      t.text :name, null: false
      t.text :internal_name, null: false
      t.text :description, null: false
      t.integer :status, default: 2, null: false
      t.datetime :starts_at, null: false
      t.datetime :ends_at
      t.timestamps null: false
    end
    add_attachment :quests, :picture
    add_index :quests, [:product_id], name: "ind_quests_products"
    add_index :quests, [:internal_name], name: "ind_quests_internal_name"
    add_index :quests, :event_id, name: "ind_quests_events", where: "(event_id IS NOT NULL)"
    add_foreign_key :quests, :products, name: "fk_quests_products"
  end
end
