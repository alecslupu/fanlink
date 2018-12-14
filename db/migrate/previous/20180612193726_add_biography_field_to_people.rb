class AddBiographyFieldToPeople < ActiveRecord::Migration[5.1]
  def change
    add_column :people, :biography, :text, default: nil, null: true
  end
end
