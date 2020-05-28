class AddPollTranslationsTable < ActiveRecord::Migration[5.2]
  def up
    unless table_exists?(:poll_translations)
      Poll.create_translation_table!({
                                              description: :text,
                                            }, {
                                              migrate_data: false,
                                              remove_source_columns: false
                                            })
    end
    rename_column :polls, :description, :untranslated_description
  end

  def down
    rename_column :polls, :untranslated_description, :description
    Poll.drop_translation_table! migrate_data: false
  end
end
