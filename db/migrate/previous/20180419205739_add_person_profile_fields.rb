class AddPersonProfileFields < ActiveRecord::Migration[5.1]
  def change
    add_column :people, :gender, :integer, default: 0, null: false
    add_column :people, :birthdate, :date
    add_column :people, :city, :text
    add_column :people, :country_code, :text
  end
end
