class AddProductToPoll < ActiveRecord::Migration[5.1]
  def change
  	add_column :polls, :product_id, :integer, null: false
  	add_foreign_key :polls, :products, name: "fk_polls_products", on_delete: :cascade
  end
  
  def up
  	change_column :polls, :description, 'jsonb USING CAST(description AS jsonb)', default: {}, null: false
  end

  def down
  	change_column :polls, :description, 'text USING CAST(description AS text)', null: false
  end
end
