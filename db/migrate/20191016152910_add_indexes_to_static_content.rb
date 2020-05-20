class AddIndexesToStaticContent < ActiveRecord::Migration[5.1]
  def change
    add_index :static_contents, [:product_id, :slug], name: "unq_static_contents_product_slug"
  end
end
