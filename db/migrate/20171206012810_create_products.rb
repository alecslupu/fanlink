class CreateProducts < ActiveRecord::Migration[5.1]
  def change
    create_table :products do |t|
      t.text :name, null: false
      t.text :subdomain, null: false
      t.boolean :enabled, default: false, null: false
      t.timestamps null: false
    end
  end
end
