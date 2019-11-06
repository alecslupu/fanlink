class ChangeRolesTable < ActiveRecord::Migration[5.1]
  def up
    add_column :roles, :post, :integer, default: 0, null: false
    add_column :roles, :chat, :integer, default: 0, null: false
    add_column :roles, :event, :integer, default: 0, null: false
    add_column :roles, :merchandise, :integer, default: 0, null: false
    add_column :roles, :badge, :integer, default: 0, null: false
    add_column :roles, :reward, :integer, default: 0, null: false
    add_column :roles, :quest, :integer, default: 0, null: false
    add_column :roles, :beacon, :integer, default: 0, null: false
    add_column :roles, :reporting, :integer, default: 0, null: false
    add_column :roles, :interest, :integer, default: 0, null: false
    add_column :roles, :courseware, :integer, default: 0, null: false
    add_column :roles, :trivia, :integer, default: 0, null: false
    add_column :roles, :admin, :integer, default: 0, null: false
    add_column :roles, :root, :integer, default: 0, null: false
    remove_column :roles, :role_enum
  end

  def down
    remove_column :roles, :post
    remove_column :roles, :chat
    remove_column :roles, :event
    remove_column :roles, :merchandise
    remove_column :roles, :badge
    remove_column :roles, :reward
    remove_column :roles, :quest
    remove_column :roles, :beacon
    remove_column :roles, :reporting
    remove_column :roles, :interest
    remove_column :roles, :courseware
    remove_column :roles, :trivia
    remove_column :roles, :admin
    remove_column :roles, :root
    add_column :roles, :role_enum, :integer, default: 0

  end
end
