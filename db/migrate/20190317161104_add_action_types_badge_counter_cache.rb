class AddActionTypesBadgeCounterCache < ActiveRecord::Migration[5.1]
  def up
    add_column :action_types, :badges_count, :integer
    ActionType.reset_column_information
    ActionType.find_each { |a| ActionType.reset_counters(a.id, :badges) }
  end

  def down
    remove_column :action_types, :badges_count
  end
end
