class CreateLessons < ActiveRecord::Migration[5.1]
  def change
    create_table :lessons do |t|
      t.integer :course_id, null: false
      t.text :name, null: false
      t.text :description, null: false
      t.datetime :start_date, null: false
      t.datetime :end_date
      t.text :video, null: false
      t.timestamps
    end
  end
end
