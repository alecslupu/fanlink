class CreateApplikations < ActiveRecord::Migration[5.1]
  def change
    create_table :applikations do |t|
      t.text :name, null: false
      t.text :subdomain, null: false
      t.boolean :enabled, default: false, null: false
      t.timestamps null: false
    end
  end
end
