class CreateFollowings < ActiveRecord::Migration[5.1]
  def up
    create_table :followings do |t|
      t.integer :follower_id, null: false
      t.integer :followed_id, null: false
      t.timestamps null: false
    end
    add_index :followings, [:follower_id, :followed_id], unique: true, name: "unq_followings_follower_followed"
    add_index :followings, :followed_id, name: "idx_followings_followed"
    add_foreign_key "followings", "people", column: "follower_id", name: "fk_followings_follower_id"
    add_foreign_key "followings", "people", column: "followed_id", name: "fk_followings_followed_id"
  end

  def down
    drop_table :followings
  end
end
