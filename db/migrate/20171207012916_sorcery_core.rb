class SorceryCore < ActiveRecord::Migration[5.1]
  def change
    create_table :people do |t|
      t.text      :name,            null: false
      t.integer   :product_id,      null: false
      t.text      :email,           null: false
      t.text      :crypted_password
      t.text      :salt
      t.timestamps null: false
    end
    add_index :people, [:product_id, :email], name: "unq_people_product_email", unique: true
    add_foreign_key :people, :products, name: "fk_people_products", on_delete: :cascade
  end
end
