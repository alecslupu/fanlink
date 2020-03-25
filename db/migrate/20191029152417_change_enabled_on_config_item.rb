class ChangeEnabledOnConfigItem < ActiveRecord::Migration[5.1]
  def up
    change_column :config_items, :enabled, :boolean, default: true
  end

  def down
    change_column :config_items, :enabled, :boolean, default: false
  end
end
