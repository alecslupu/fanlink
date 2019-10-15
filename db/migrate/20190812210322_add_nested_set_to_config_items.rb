class AddNestedSetToConfigItems < ActiveRecord::Migration[5.1]
  def change
    add_column :config_items, :parent_id, :integer, null: true, index: true
    add_column :config_items, :lft, :integer, null: false, index: true, default: 0
    add_column :config_items, :rgt, :integer, null: false, index: true, default: 0
    add_column :config_items, :depth, :integer, null: false, default: 0
    add_column :config_items, :children_count, :integer, null: true, default: 0
  end
end
