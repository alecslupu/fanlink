class CreateQuest < ActiveRecord::Migration[5.1]
  def up
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
    add_column :quests, :picture_meta, :text

    rename_column :quests, :name, :name_text_old
    rename_column :quests, :description, :description_text_old

    change_column_null :quests, :name_text_old, true
    change_column_null :quests, :description_text_old, true

    add_column :quests, :name, :jsonb, default: {}, null: false
    add_column :quests, :description, :jsonb, default: {}, null: false

    Quest.all.each do |q|
      unless q.name_text_old.nil?
        q.name = q.name_text_old
      end
      unless q.description_text_old.nil?
        q.description = q.description_text_old
      end
      q.save
    end
  end

  def down
    drop_table :quests
  end
end


