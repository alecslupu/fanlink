class SorceryCore < ActiveRecord::Migration[5.1]
  def change
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
  end
end
