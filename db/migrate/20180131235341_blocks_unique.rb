class BlocksUnique < ActiveRecord::Migration[5.1]
  def up
    add_index :blocks, %i[ blocker_id blocked_id ], name: "unq_blocks_blocker_blocked", unique: true
  end
  def down
    remove_index :blocks, name: "unq_blocks_blocker_blocked"
  end
end
