class CreateStaticContent < ActiveRecord::Migration[5.1]
  def change
    create_table :static_contents do |t|
      t.string :content, default: "", null: false
      t.string :title
      t.string :slug, null: false
      t.integer :product_id, :integer, null: false

      t.timestamps
    end
  end
end
