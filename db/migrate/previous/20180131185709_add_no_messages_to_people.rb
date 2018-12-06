class AddNoMessagesToPeople < ActiveRecord::Migration[5.1]
  def change
    add_column :people, :do_not_message_me, :boolean, default: false, null: false
  end
end
