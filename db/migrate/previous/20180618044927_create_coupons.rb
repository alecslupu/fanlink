class CreateCoupons < ActiveRecord::Migration[5.1]
  def change
    create_table :coupons do |t|
      t.integer :product_id, null: false
      t.text :code, null: false
      t.text :description, null: false
      t.text :url, default: nil
      t.boolean :deleted, default: false
    end
  end
end
