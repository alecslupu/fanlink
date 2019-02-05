class CreateRole < ActiveRecord::Migration[5.1]
  def change
    create_table :roles do |t|
      t.string :name, null: false
      t.string :internal_name, null: false
      t.integer :role_enum, default: 0
      t.timestamps null: false
    end
  end
end
