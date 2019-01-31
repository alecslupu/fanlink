class ChangeDescriptionTypeInPollOptions < ActiveRecord::Migration[5.1]
  def up
  	rename_column :poll_options, :description, :description_old
  	add_column :poll_options, :description, :jsonb , default: {}, null: false
  end

  def down
  	remove_column :poll_options, :description
  	rename_column :poll_options, :description_old, :description
  end
end
