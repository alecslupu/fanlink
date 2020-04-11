class AddQuestActivityTranslationsTable < ActiveRecord::Migration[5.2]
  def up
    unless table_exists?(:quest_activity_translations)
      QuestActivity.create_translation_table!({
                                                description: :text,
                                                name: :string,
                                                hint: :text,
                                                title: :string
                                      }, {
                                        migrate_data: false,
                                        remove_source_columns: false
                                      })
    end
    if column_exists? :quest_activities, :description
      rename_column :quest_activities, :description, :untranslated_description
    end
    if column_exists? :quest_activities, :name
      rename_column :quest_activities, :name, :untranslated_name
    end
    if column_exists? :quest_activities, :hint
      rename_column :quest_activities, :hint, :untranslated_hint
    end
    if column_exists? :quest_activities, :title
      rename_column :quest_activities, :title, :untranslated_title
    end
  end

  def down
    rename_column :quest_activities, :untranslated_title, :title
    rename_column :quest_activities, :untranslated_hint, :hint
    rename_column :quest_activities, :untranslated_description, :description
    rename_column :quest_activities, :untranslated_name, :name
    QuestActivity.drop_translation_table! migrate_data: false
  end
end
