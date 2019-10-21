class AddMobileUrlsToProduct < ActiveRecord::Migration[5.1]
  def self.up
    unless column_exists? :products, :android_url
      add_column :products, :android_url, :text
    end
    unless column_exists? :products, :ios_url
      add_column :products, :ios_url, :text
    end
  end

  def self.down
    remove_column :products, :android_url
    remove_column :products, :ios_url
  end
end
