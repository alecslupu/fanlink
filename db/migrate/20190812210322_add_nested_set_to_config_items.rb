class AddNestedSetToConfigItems < ActiveRecord::Migration[5.1]
  def self.up
    unless column_exists?(:config_items, :parent_id)
      add_column :config_items, :parent_id, :integer, null: true, index: true
    end
    unless column_exists?(:config_items, :lft)
      add_column :config_items, :lft, :integer, null: false, index: true, default: 0
    end
    unless column_exists?(:config_items, :rgt)
      add_column :config_items, :rgt, :integer, null: false, index: true, default: 0
    end
    unless column_exists?(:config_items, :depth)
      add_column :config_items, :depth, :integer, null: false, default: 0
    end
    unless column_exists?(:config_items, :children_count)
      add_column :config_items, :children_count, :integer, null: true, default: 0
    end
  end

  def self.down
    remove_column :config_items, :parent_id
    remove_column :config_items, :lft
    remove_column :config_items, :rgt
    remove_column :config_items, :depth
    remove_column :config_items, :children_count
  end
end
