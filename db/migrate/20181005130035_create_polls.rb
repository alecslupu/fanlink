class CreatePolls < ActiveRecord::Migration[5.1]
  def change
    create_table :polls do |t|
      t.text :description, null: false
      t.datetime :start_date
      t.time :duration
      t.string :poll_status

      t.timestamps
    end
  end
end
