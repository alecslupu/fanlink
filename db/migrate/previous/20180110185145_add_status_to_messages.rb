class AddStatusToMessages < ActiveRecord::Migration[5.1]
  def up
    add_column :messages, :status, :integer, default: 0, null: false
    Message.update_all(status: :posted)
  end

  def down
    remove_column :messages, :status
  end
end
