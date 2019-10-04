class AddItemUrlToConfigItem < ActiveRecord::Migration[5.1]
  def change
    add_column :config_items, :item_url, :string
    add_column :config_items, :item_description, :string
  end
end
