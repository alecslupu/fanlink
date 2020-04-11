class AddIntrestTranslationsTable < ActiveRecord::Migration[5.2]
  def up
    unless table_exists?(:interest_translations)
      Interest.create_translation_table!({
                                           title: :text,
                                           }, {
                                             migrate_data: false,
                                             remove_source_columns: false
                                           })
    end
    rename_column :interests, :title, :untranslated_title
  end

  def down
    rename_column :interests, :untranslated_title, :title
    Interest.drop_translation_table! migrate_data: false
  end
end
