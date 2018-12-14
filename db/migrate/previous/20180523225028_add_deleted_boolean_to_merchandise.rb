class AddDeletedBooleanToMerchandise < ActiveRecord::Migration[5.1]
  def change
    add_column :merchandise, :deleted, :boolean, default: false, null: false
  end
end
