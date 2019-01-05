class CreatePolls < ActiveRecord::Migration[5.1]
  def change
    create_table :polls do |t|
      t.text :description, null: false
      t.integer :poll_type, null: false
      t.integer :poll_type_id, null: false
      t.datetime :start_date, null: false
      t.integer :duration, default: 0, null: false
      t.string :poll_status, null:false

      t.timestamps
    end

    add_index :polls, [:poll_type, :poll_type_id], name: "unq_polls_type_poll_type_id", unique: true
  end
end