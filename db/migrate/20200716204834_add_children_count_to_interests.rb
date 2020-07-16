class AddChildrenCountToInterests < ActiveRecord::Migration[6.0]
  def change
    add_column :interests, :children_count, :integer, default: 0
  end
end
