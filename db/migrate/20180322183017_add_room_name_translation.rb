class AddRoomNameTranslation < ActiveRecord::Migration[5.1]
  def up
    remove_column :rooms, :name_canonical
    rename_column :rooms, :name, :name_text_old
    add_column :rooms, :name, :jsonb, default: {}, null: false
    Room.all.each do |r|
      unless r.name_text_old.nil?
        r.name = r.name_text_old
        r.save
      end
    end
  end

  def down
    remove_column :rooms, :name
    rename_column :rooms, :name_text_old, :name
    add_column :rooms, :name_canonical, :text
  end
end
