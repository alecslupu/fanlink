class AddFieldsToActivityType < ActiveRecord::Migration[5.1]
  def change
    add_column :activity_types, :created_at, :datetime, null: false
    add_column :activity_types, :updated_at, :datetime, null: false
  end
end
