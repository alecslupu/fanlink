class AddItemUrlToConfigItem < ActiveRecord::Migration[5.1]
  def self.up
    unless column_exists?(:config_items, :item_url)
      add_column :config_items, :item_url, :string
    end
    unless column_exists?(:config_items, :item_description)
      add_column :config_items, :item_description, :string
    end
  end
  def self.down
    remove_column :config_items, :item_url
    remove_column :config_items, :item_description
  end
end
