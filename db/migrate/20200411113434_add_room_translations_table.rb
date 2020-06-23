class AddRoomTranslationsTable < ActiveRecord::Migration[5.2]
  def up
    unless table_exists?(:room_translations)
      Room.create_translation_table!({
                                        description: :text,
                                        name: :string
                                      }, {
                                        migrate_data: false,
                                        remove_source_columns: false
                                      })
    end
    rename_column :rooms, :description, :untranslated_description
    rename_column :rooms, :name, :untranslated_name
  end

  def down
    rename_column :rooms, :untranslated_description, :description
    rename_column :rooms, :untranslated_name, :name
    Room.drop_translation_table! migrate_data: false
  end
end
