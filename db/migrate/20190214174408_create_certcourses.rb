class CreateCertcourses < ActiveRecord::Migration[5.1]
  def change
    create_table :certcourses do |t|
      t.string :long_name, null: false
      t.string :short_name, null: false
      t.jsonb :description, default: {}, null: false
      t.integer :status, default: 0, null: false
      t.integer :duration
      t.boolean :is_completed, default: false
      t.jsonb :copyright_text, default: {}, null: false

      t.timestamps
    end
  end
end
