class CreateCertcoursePages < ActiveRecord::Migration[5.1]
  def change
    create_table :certcourse_pages do |t|
      t.references :certcourse, foreign_key: true
      t.integer :order, default: 0, null: false
      t.integer :duration, default: 0, null: false

      t.timestamps
    end
  end
end
