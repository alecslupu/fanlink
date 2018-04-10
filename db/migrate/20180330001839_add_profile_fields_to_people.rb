class AddProfileFieldsToPeople < ActiveRecord::Migration[5.1]
  def change
    add_column :people, :birthdate, :date
    add_column :people, :city, :text
    add_column :people, :country, :text
    add_column :people, :gender, :text
  end
end
