class AddSomeMissingTimestamps < ActiveRecord::Migration[5.1]
  def up
    add_column :rooms, :created_at, :datetime
    add_column :rooms, :updated_at, :datetime
    Room.where(created_at: nil).update_all(created_at: Time.now, updated_at: Time.now)
    change_column_null :rooms, :created_at, false
    change_column_null :rooms, :updated_at, false
  end
  def down
    remove_column :rooms, :created_at
    remove_column :rooms, :updated_at
  end
end
