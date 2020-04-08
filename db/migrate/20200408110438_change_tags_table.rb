class ChangeTagsTable < ActiveRecord::Migration[5.2]
  def up
    rename_table :tags, :old_tags
  end
  def down
    rename_table :tags, :old_tags
  end
end
