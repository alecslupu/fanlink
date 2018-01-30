class CreateLevels < ActiveRecord::Migration[5.1]
  def up
    create_table :levels do |t|
      t.integer :product_id, null: false
      t.text :name, null: false
      t.text :internal_name, null: false
      t.integer :points, default: 1000, null: false
      t.timestamps null:false
      t.index ["product_id", "internal_name"], name: "unq_levels_product_internal_name"
      t.index ["product_id", "points"], name: "unq_levels_product_points"
    end
    add_attachment :levels, :picture
    add_foreign_key :levels, :products, name: "fk_levels_products"
  end
  def down
    drop_table :levels
  end
end
