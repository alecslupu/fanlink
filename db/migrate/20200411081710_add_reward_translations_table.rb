class AddRewardTranslationsTable < ActiveRecord::Migration[5.2]

  def up
    unless table_exists?(:reward_translations)
      Reward.create_translation_table!({
                                        name: :string
                                      }, {
                                        migrate_data: false,
                                        remove_source_columns: false
                                      })
    end
    rename_column :rewards, :name, :untranslated_name
  end

  def down
    rename_column :rewards, :untranslated_name, :name
    Reward.drop_translation_table! migrate_data: false
  end
end
