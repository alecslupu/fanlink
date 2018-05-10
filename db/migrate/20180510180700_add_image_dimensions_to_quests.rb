class AddImageDimensionsToQuests < ActiveRecord::Migration[5.1]
  def change
    add_column :quests, :picture_meta, :text
  end
end
