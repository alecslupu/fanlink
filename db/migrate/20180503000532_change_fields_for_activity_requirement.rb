class RenameFieldsForQuestActivity < ActiveRecord::Migration[5.1]
  def change
    change_table :quest_activity do |t|
      t.rename :requires, :beacon
    end
  end
end
