class RemoveOldDescriptFieldsFromPolls < ActiveRecord::Migration[5.1]
  def change
    remove_column :polls, :description_old
  end
end
