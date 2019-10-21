class AddIndexesToBadges < ActiveRecord::Migration[5.1]
  def change
    add_index :badges, [:product_id, :internal_name], name: "unq_badges_product_internal_name", unique: true
    add_index :badges, [:product_id, :name], name: "unq_badges_product_name", unique: true
  end
end
