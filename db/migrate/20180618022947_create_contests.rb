class CreateContests < ActiveRecord::Migration[5.1]
  def change
    create_table :contests do |t|
      t.integer :product_id, null: false
      t.text :name, null: false
      t.text :internal_name
      t.text :description, null: false
      t.text :rules_url, default: nil
      t.text :contest_url, default: nil
      t.integer :status, default: 0
      t.boolean :deleted, default: false
      t.timestamps null: false
    end
  end
end
