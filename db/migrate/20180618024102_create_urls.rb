class CreateUrls < ActiveRecord::Migration[5.1]
  def change
    create_table :urls do |t|
      t.integer :product_id, null: false
      t.text :displayed_url, null: false
      t.boolean :protected, default: false
      t.boolean :deleted, default: false
    end
  end
end
