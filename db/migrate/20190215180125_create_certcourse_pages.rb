class CreateCertcoursePages < ActiveRecord::Migration[5.1]
  def change
    create_table :certcourse_pages do |t|
      t.integer :certcourse_id
      t.integer :order, default: 0, null: false
      t.integer :duration, default: 0, null: false

      t.timestamps
    end
    add_index :certcourse_pages, %i[ certcourse_id ], name: "idx_certcourse_pages_certcourse"
    add_foreign_key :certcourse_pages, :certcourses, name: "fk_certcourse_pages_certcourse"
  end
end
