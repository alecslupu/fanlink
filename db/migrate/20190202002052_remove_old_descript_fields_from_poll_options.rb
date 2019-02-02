class RemoveOldDescriptFieldsFromPollOptions < ActiveRecord::Migration[5.1]
  def change
    remove_column :poll_options, :description_old
  end
end
