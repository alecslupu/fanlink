class ChangePrereqstepToArray < ActiveRecord::Migration[5.1]
  def change
    remove_column :steps, :prereq_step
    add_column :steps, :unlocks, :integer, array: true, default: [], null: false
    add_index :steps, :unlocks, using: 'gin'
  end
end
