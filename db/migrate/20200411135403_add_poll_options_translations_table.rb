class AddPollOptionsTranslationsTable < ActiveRecord::Migration[5.2]
  def up
    unless table_exists?(:poll_option_translations)
      PollOption.create_translation_table!({
                                       description: :text,
                                     }, {
                                       migrate_data: false,
                                       remove_source_columns: false
                                     })
    end
    rename_column :poll_options, :description, :untranslated_description
  end

  def down
    rename_column :poll_options, :untranslated_description, :description
    PollOption.drop_translation_table! migrate_data: false
  end
end
