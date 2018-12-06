class CreateCourses < ActiveRecord::Migration[5.1]
  def change
    create_table :courses do |t|
      t.integer :semester_id, null: false
      t.text :name, null: false
      t.text :description, null: false
      t.datetime :start_date, null: false
      t.datetime :end_date
      t.timestamps
    end
  end
end
