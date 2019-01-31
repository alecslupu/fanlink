class ChangeDescriptionTypeInPolls < ActiveRecord::Migration[5.1]
  def up
  	rename_column :polls, :description, :description_old
  	add_column :polls, :description, :jsonb , default: {}, null: false
  end

  def down
  	remove_column :polls, :description
  	rename_column :polls, :description_old, :description
  end
end
