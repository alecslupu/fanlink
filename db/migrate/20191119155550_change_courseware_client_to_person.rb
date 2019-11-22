class ChangeCoursewareClientToPerson < ActiveRecord::Migration[5.1]
  def up
    remove_column :client_to_people, :relation_type
    add_column :client_to_people, :type, :string, null: false
  end

  def down
    remove_column :client_to_people, :type
    add_column :client_to_people, :relation_type, :integer, default: 0

  end
end
