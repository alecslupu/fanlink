class AddDescriptionToLevels < ActiveRecord::Migration[5.1]
  def change
    add_column :levels, :description, :jsonb, default: {}, null: false
  end
end
