class ChangeInternalNameOnProduct < ActiveRecord::Migration[5.1]
  def up
    change_column :products, :internal_name, :string
    change_column :products, :name, :string
  end

  def down
    change_column :products, :internal_name, :text
    change_column :products, :internal_name, :text
  end
end
