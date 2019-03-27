class AddActionTypesCounterCache < ActiveRecord::Migration[5.1]
  def up
    add_column :action_types, :badge_actions_count, :integer
    ActionType.reset_column_information
    ActionType.find_each { |a| ActionType.reset_counters(a.id, :badge_actions) }
  end

  def down
    remove_column :action_types, :badge_actions_count
  end
end
