class CreateSemesters < ActiveRecord::Migration[5.1]
  def change
    create_table :semesters do |t|
      t.integer :product_id, null: false
      t.text :name, null: false
      t.text :description, null: false
      t.datetime :start_date, null: false
      t.datetime :end_date
      t.timestamps null: false
    end
  end
end
