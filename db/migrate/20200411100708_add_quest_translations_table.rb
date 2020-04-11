class AddQuestTranslationsTable < ActiveRecord::Migration[5.2]
  def up
    unless table_exists?(:quest_translations)
      Quest.create_translation_table!({
                                        description: :text,
                                        name: :string
                                      }, {
                                        migrate_data: false,
                                        remove_source_columns: false
                                      })
    end
    rename_column :quests, :description, :untranslated_description
    rename_column :quests, :name, :untranslated_name
  end

  def down
    rename_column :quests, :untranslated_description, :description
    rename_column :quests, :untranslated_name, :name
    Badge.drop_translation_table! migrate_data: false
  end
end
