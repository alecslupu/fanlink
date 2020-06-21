class CreatePosts < ActiveRecord::Migration[5.1]
  def up
    create_table :posts do |t|
      t.integer :person_id, null: false
      t.text :body, null: false
      t.text :picture_id
      t.boolean :global, default: false, null: false
      t.datetime :starts_at
      t.datetime :ends_at
      t.integer :repost_interval, default: 0, null: false
      t.integer :status, default: 0, null: false
      t.timestamps null: false
    end
    add_index :posts, [:person_id], name: "idx_posts_person"
    add_foreign_key :posts, :people, name: "fk_posts_people", on_delete: :cascade

    remove_column :posts, :picture_id
    add_attachment :posts, :picture
    change_column_null :posts, :body, true

    rename_column :posts, :body, :body_text_old
    add_column :posts, :body, :jsonb, default: {}, null: false

    Post.all.each do |p|
      if p.body_text_old.present?
        p.body = p.body_text_old
        p.save
      end
    end
    add_column :posts, :priority, :integer, default: 0, null: false
    add_index :posts, %i[ person_id priority], name: "idx_posts_person_priority"
    add_column :posts, :recommended, :boolean, default: false, null: false
    add_index :posts, :recommended, where: "recommended = true"
    add_column :posts, :notify_followers, :boolean, default: false, null: false

    change_table :posts do |t|
      t.attachment :audio
    end
    add_column :posts, :category_id, :integer, default: nil

  end

  def down
    drop_table :posts
  end
end
