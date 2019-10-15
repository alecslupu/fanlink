class AddMobileUrlsToProduct < ActiveRecord::Migration[5.1]
  def change
    add_column :products, :android_url, :text
    add_column :products, :ios_url, :text
  end
end
