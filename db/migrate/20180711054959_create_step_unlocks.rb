class CreateStepUnlocks < ActiveRecord::Migration[5.1]
  def change
    create_table :step_unlocks do |t|
      t.uuid :step_id, null: false
      t.uuid :unlock_id, null: false
    end
  end
end
