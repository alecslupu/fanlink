class CreateBlocks < ActiveRecord::Migration[5.1]
  def up
    create_table :blocks do |t|
      t.integer :blocker_id, null: false
      t.integer :blocked_id, null: false
      t.datetime :created_at, null: false
    end
    add_index :blocks, :blocker_id, name: "ind_blocks_blocker"
    add_foreign_key :blocks, :people, column: :blocker_id, name: "fk_blocks_people_blocker", on_delete: :cascade
    add_foreign_key :blocks, :people, column: :blocked_id, name: "fk_blocks_people_blocked", on_delete: :cascade
    add_index :blocks, %i[ blocker_id blocked_id ], name: "unq_blocks_blocker_blocked", unique: true

  end

  def down
    drop_table :blocks
  end
end
