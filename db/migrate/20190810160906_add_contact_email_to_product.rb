class AddContactEmailToProduct < ActiveRecord::Migration[5.1]
  def self.up
    unless column_exists?(:products, :contact_email)
      add_column :products, :contact_email, :string
    end
  end
  def self.down
    remove_column :products, :contact_email
  end
end
