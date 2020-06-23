class CreateBadges < ActiveRecord::Migration[5.1]
  def up
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
    add_column :badges, :point_value, :integer, default: 0, null: false

    remove_column :badges, :picture_id
    add_attachment :badges, :picture

    add_column :badges, :description, :text

    add_column :badges, :issued_from, :datetime
    add_column :badges, :issued_to, :datetime
    add_index :badges, %i[ issued_from ], name: "ind_badges_issued_from"
    add_index :badges, %i[ issued_to ], name: "ind_badges_issued_to"

    rename_column :badges, :name, :name_text_old
    change_column_null :badges, :name_text_old, true
    rename_column :badges, :description, :description_text_old
    change_column_null :badges, :description_text_old, true
    add_column :badges, :name, :jsonb, default: {}, null: false
    add_column :badges, :description, :jsonb, default: {}, null: false

    Badge.all.each do |b|
      unless b.name_text_old.nil?
        b.name = b.name_text_old
      end
      unless b.description_text_old.nil?
        b.description = b.description_text_old
      end
      b.save
    end
  end

  def down
    drop_table :badges
  end
end
