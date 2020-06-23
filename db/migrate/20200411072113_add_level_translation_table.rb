class AddLevelTranslationTable < ActiveRecord::Migration[5.2]
  def up
    unless table_exists?(:level_translations)
      Level.create_translation_table!({
                                        description: :text,
                                        name: :string
                                     }, {
                                       migrate_data: false,
                                       remove_source_columns: false
                                     })
    end
    rename_column :levels, :description, :untranslated_description
    rename_column :levels, :name, :untranslated_name
  end

  def down
    rename_column :levels, :untranslated_description, :description
    rename_column :levels, :untranslated_name, :name
    Level.drop_translation_table! migrate_data: false
  end
end
