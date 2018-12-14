class SetValueDefaultValueForActivityType < ActiveRecord::Migration[5.1]
  def change
    change_column :activity_types, :value, :jsonb, :default => {}, null: false
  end
end
