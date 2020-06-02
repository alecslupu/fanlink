class CreateRooms < ActiveRecord::Migration[5.1]
  def up
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

    change_column_null :rooms, :name, true
    change_column_null :rooms, :name_canonical, true

    add_column :rooms, :created_at, :datetime
    add_column :rooms, :updated_at, :datetime
    Room.where(created_at: nil).update_all(created_at: Time.now, updated_at: Time.now)
    change_column_null :rooms, :created_at, false
    change_column_null :rooms, :updated_at, false

    remove_column :rooms, :picture_id
    add_attachment :rooms, :picture

    change_column_null :rooms, :created_by_id, true

    remove_column :rooms, :name_canonical
    rename_column :rooms, :name, :name_text_old
    add_column :rooms, :name, :jsonb, default: {}, null: false
    Room.all.each do |r|
      unless r.name_text_old.nil?
        r.name = r.name_text_old
        r.save
      end
    end
    add_column :rooms, :description, :jsonb, default: {}, null: false

  end

  def down
    remove_column :rooms, :created_at
    remove_column :rooms, :updated_at
    drop_table :rooms
  end
end
