class AddTesterFlagToPerson < ActiveRecord::Migration[5.1]
  def change
    add_column :person, :tester, :boolean, default: :false
  end
end
