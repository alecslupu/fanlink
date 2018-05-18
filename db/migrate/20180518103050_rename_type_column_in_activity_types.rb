class RenameTypeColumnInActivityTypes < ActiveRecord::Migration[5.1]
  def change
    rename_column :activity_types, :type, :atype
  end
end
