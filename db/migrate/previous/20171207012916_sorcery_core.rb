class SorceryCore < ActiveRecord::Migration[5.1]
  def up
    create_table :people do |t|
      t.text      :username,            null: false
      t.text      :username_canonical,  null: false
      t.text      :email,               null: false
      t.text      :name
      t.text      :picture_id
      t.integer   :product_id,          null: false
      t.text      :crypted_password
      t.text      :salt
      t.timestamps null: false
    end
    add_index :people, [:product_id, :email], name: "unq_people_product_email", unique: true
    add_index :people, [:product_id, :username_canonical], name: "unq_people_product_username_canonical", unique: true
    add_foreign_key :people, :products, name: "fk_people_products", on_delete: :cascade

    add_column :people, :facebookid, :text
    add_column :people, :facebook_picture_url, :text
    change_column :people, :email, :text, null: true
    add_index :people, [:product_id, :facebookid], name: "unq_people_product_facebook", unique: true

    remove_column :people, :picture_id
    change_table :people do |t|
      t.attachment :picture
    end

    add_column :people, :do_not_message_me, :boolean, default: false, null: false
    add_column :people, :pin_messages_from, :boolean, default: false, null: false

    add_column :people, :auto_follow, :boolean, default: false, null: false
    add_index :people, %i[ product_id auto_follow ], name: "idx_people_product_auto_follow"
    add_column :people, :role, :integer, default: 0, null: false

    add_column :people, :reset_password_token, :text
    add_column :people, :reset_password_token_expires_at, :datetime
    add_column :people, :reset_password_email_sent_at, :datetime
    add_column :people, :product_account, :boolean, default: false, null: false
    add_column :people, :chat_banned, :boolean, default: false, null: false
    add_column :people, :recommended, :boolean, default: false, null: false
    add_column :people, :designation, :jsonb, default: {}, null: false

    add_column :people, :gender, :integer, default: 0, null: false
    add_column :people, :birthdate, :date
    add_column :people, :city, :text
    add_column :people, :country_code, :text
    add_column :people, :biography, :text, default: nil, null: true

  end

  def down
    drop_table :people
  end
end
