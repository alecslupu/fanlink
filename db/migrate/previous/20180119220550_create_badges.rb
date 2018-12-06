class CreateBadges < ActiveRecord::Migration[5.1]
  def change
    create_table :badges do |t|
      t.integer :product_id, null: false
      t.text :name, null: false
      t.text :internal_name, null: false
      t.text :picture_id
      t.integer :action_type_id, null: false
      t.integer :action_requirement, default: 1, null: false
      t.timestamps null: false
    end
    add_index :action_types, [:product_id], name: "idx_badges_product"
    add_index :action_types, [:product_id, :internal_name], name: "unq_badges_product_internal_name", unique: true
    add_index :action_types, [:product_id, :name], name: "unq_badges_product_name", unique: true
    add_foreign_key :badges, :products, name: "fk_badges_product", on_delete: :cascade
    add_foreign_key :badges, :action_types, name: "fk_badges_action_type", on_delete: :restrict
  end
end
