class CreateStaticContent < ActiveRecord::Migration[5.1]
  def change
    create_table :static_contents do |t|
      t.jsonb :content, default: "", null: false
      t.jsonb :title, null: false
      t.string :slug, null: false
      t.integer :product_id, null: false

      t.timestamps
    end
  end
end
