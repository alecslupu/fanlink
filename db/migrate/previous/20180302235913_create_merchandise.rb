class CreateMerchandise < ActiveRecord::Migration[5.1]
  def up
    create_table :merchandise do |t|
      t.integer :product_id, null: false
      t.text :name, null: false
      t.text :description
      t.text :price
      t.text :purchase_url
      t.string :picture_file_name
      t.string :picture_content_type
      t.integer :picture_file_size
      t.datetime :picture_updated_at
      t.timestamps null: false
    end
    add_index :merchandise, %i[ product_id ], name: "idx_merchandise_product"
    add_foreign_key :merchandise, :products, name: "fk_merchandise_products"
    add_column :merchandise, :available, :boolean, default: true, null: false

    add_column :merchandise, :priority, :integer, default: 0, null: false
    add_index :merchandise, %i[ product_id priority], name: "idx_merchandise_product_priority"
    rename_column :merchandise, :name, :name_text_old
    change_column_null :merchandise, :name_text_old, true
    rename_column :merchandise, :description, :description_text_old
    add_column :merchandise, :name, :jsonb, default: {}, null: false
    add_column :merchandise, :description, :jsonb, default: {}, null: false

    Merchandise.all.each do |m|
      if m.name_text_old.present?
        m.name = m.name_text_old
      end
      if m.description_text_old.present?
        m.description = m.description_text_old
      end
      m.save
    end
    add_column :merchandise, :deleted, :boolean, default: false, null: false

  end
  def down
    drop_table :merchandise
  end
end
