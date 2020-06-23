class AddBadgeTranslationsTable < ActiveRecord::Migration[5.2]

  def up
    unless table_exists?(:badge_translations)
      Badge.create_translation_table!({
                                        description: :text,
                                        name: :string
                                      }, {
                                        migrate_data: false,
                                        remove_source_columns: false
                                      })
    end
    rename_column :badges, :description, :untranslated_description
    rename_column :badges, :name, :untranslated_name
  end

  def down
    rename_column :badges, :untranslated_description, :description
    rename_column :badges, :untranslated_name, :name
    Badge.drop_translation_table! migrate_data: false
  end
end
