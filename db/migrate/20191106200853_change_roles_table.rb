class ChangeRolesTable < ActiveRecord::Migration[5.1]
  def up

    [:post, :chat, :event, :merchandise, :badge,:reward, :quest,:beacon, :reporting,:interest, :courseware, :trivia, :admin, :root].each do |column|
      unless column_exists? :roles, column
        add_column :roles, column, :integer, default: 0, null: false
      end
    end

    if column_exists? :roles, :role_enum
      remove_column :roles, :role_enum
    end
  end

  def down
    [:post, :chat, :event, :merchandise, :badge,:reward, :quest,:beacon, :reporting,:interest, :courseware, :trivia, :admin, :root].each do |column|
      remove_column :roles, column
    end
    add_column :roles, :role_enum, :integer, default: 0

  end
end
