class AddPrivacyUrlToProduct < ActiveRecord::Migration[5.1]
  def change
    add_column :products, :privacy_url, :text
  end
end
