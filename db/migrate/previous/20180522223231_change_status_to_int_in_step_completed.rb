class ChangeStatusToIntInStepCompleted < ActiveRecord::Migration[5.1]
  def change
    rename_column :step_completed, :status, :status_old
    add_column :step_completed, :status, :integer, default: 0, null: false
  end
end
