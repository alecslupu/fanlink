class CreateLevels < ActiveRecord::Migration[5.1]
  def up
    create_table :levels do |t|
      t.integer :product_id, null: false
      t.text :name, null: false
      t.text :internal_name, null: false
      t.integer :points, default: 1000, null: false
      t.timestamps null: false
      t.index ["product_id", "internal_name"], name: "unq_levels_product_internal_name"
      t.index ["product_id", "points"], name: "unq_levels_product_points"
    end
    add_attachment :levels, :picture
    add_foreign_key :levels, :products, name: "fk_levels_products"
    add_column :levels, :description, :jsonb, default: {}, null: false

    rename_column :levels, :name, :name_text_old
    change_column_null :levels, :name_text_old, true
    add_column :levels, :name, :jsonb, default: {}, null: false

    Level.all.each do |l|
      unless l.name_text_old.nil?
        l.name = l.name_text_old
        l.save
      end
    end
  end
  def down
    drop_table :levels
  end
end
