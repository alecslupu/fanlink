class CreateNotifications < ActiveRecord::Migration[5.1]
  def up
    unless table_exists? :notifications
      create_table :notifications do |t|
        t.text :body, null: false
        t.references :person, foreign_key: true

        t.timestamps
      end
    end
  end
  def down
    drop_table :notifications
  end
end
