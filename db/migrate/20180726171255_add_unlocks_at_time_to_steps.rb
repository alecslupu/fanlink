class AddUnlocksAtTimeToSteps < ActiveRecord::Migration[5.1]
  def change
    add_column :steps, :unlocks_at, :timestamp, default: nil
  end
end
