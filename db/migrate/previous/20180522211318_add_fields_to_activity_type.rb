class AddFieldsToActivityType < ActiveRecord::Migration[5.1]
  def change
    add_column :activity_types, :created_at, :datetime, null: false, default: -> { 'CURRENT_TIMESTAMP' }
    add_column :activity_types, :updated_at, :datetime, null: false, default: -> { 'CURRENT_TIMESTAMP' }
  end
end
