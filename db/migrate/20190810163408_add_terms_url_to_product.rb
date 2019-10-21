class AddTermsUrlToProduct < ActiveRecord::Migration[5.1]
  def self.up
    unless column_exists? :products, :terms_url
      add_column :products, :terms_url, :text
    end
  end
  def self.down
    remove_column :products, :terms_url
  end
end
