class AddPrivacyUrlToProduct < ActiveRecord::Migration[5.1]
  def self.up
    unless column_exists? :products, :privacy_url
      add_column :products, :privacy_url, :text
    end
  end
  def self.down
    remove_column :products, :privacy_url
  end
end
