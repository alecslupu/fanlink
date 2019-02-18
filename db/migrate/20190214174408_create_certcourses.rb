class CreateCertcourses < ActiveRecord::Migration[5.1]
  def change
    create_table :certcourses do |t|
      t.string :long_name, null: false
      t.string :short_name, null: false
      t.text :description, default: "", null: false
      t.integer :status, default: 0, null: false
      t.integer :duration, default: 0, null: false
      t.boolean :is_completed, default: false
      t.text :copyright_text, default: "", null: false

      t.timestamps
    end
  end
end
