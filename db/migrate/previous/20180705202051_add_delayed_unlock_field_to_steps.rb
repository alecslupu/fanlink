class AddDelayedUnlockFieldToSteps < ActiveRecord::Migration[5.1]
  def change
    add_column :steps, :delay_unlock, :integer, default: 0
  end
end
