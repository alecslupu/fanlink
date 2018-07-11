class ChangeUnlocksFromIntegerToString < ActiveRecord::Migration[5.1]
  def change
    rename_column :steps, :unlocks, :int_unlocks
    add_column :steps, :unlocks, :text, default: nil
  end
end
