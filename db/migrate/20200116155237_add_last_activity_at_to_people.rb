class AddLastActivityAtToPeople < ActiveRecord::Migration[5.1]
  def up
    add_column :people, :last_activity_at, :datetime
  end

  def down
    remove_column :people, :last_activity_at
  end
end
