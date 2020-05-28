class AddLocaleToVersions < ActiveRecord::Migration[5.2]
  def change
    add_column :versions, :locale, :string
  end
end
