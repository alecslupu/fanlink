class AddAccountDisabledAndReasonFieldToPeople < ActiveRecord::Migration[5.1]
  def change
    add_column :people, :terminated, :boolean, default: false
    add_column :people, :terminated_reason, :text
  end
end
