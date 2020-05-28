class AddMerchandiseTranslationsTable < ActiveRecord::Migration[5.2]
  def up
    unless table_exists?(:merchandise_translations)
      Merchandise.create_translation_table!({
                                       description: :text,
                                       name: :string
                                     }, {
                                       migrate_data: false,
                                       remove_source_columns: false
                                     })
    end
    rename_column :merchandise, :description, :untranslated_description
    rename_column :merchandise, :name, :untranslated_name
  end

  def down
    rename_column :merchandise, :untranslated_description, :description
    rename_column :merchandise, :untranslated_name, :name
    Merchandise.drop_translation_table! migrate_data: false
  end
end
