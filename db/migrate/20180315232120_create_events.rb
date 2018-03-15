class CreateEvents < ActiveRecord::Migration[5.1]
  def change
    create_table :events do |t|
      t.text :name, null: false
      t.datetime :start_time, null: false
      t.text :ticket_url
      t.text :place_identifier
      t.timestamps null: false
    end
  end
end
