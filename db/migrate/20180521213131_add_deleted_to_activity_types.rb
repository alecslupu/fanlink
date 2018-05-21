class AddDeletedToActivityTypes < ActiveRecord::Migration[5.1]
  def change
    add_column :activity_types, :deleted, :boolean, default: false, null: false
  end
end
