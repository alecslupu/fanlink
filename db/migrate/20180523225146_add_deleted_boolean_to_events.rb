class AddDeletedBooleanToEvents < ActiveRecord::Migration[5.1]
  def change
    add_column :events, :deleted, :boolean, default: false, null: false
  end
end
