class AddTranslationForStaticWebContent < ActiveRecord::Migration[5.2]
  def up
    Static::WebContent.create_translation_table!({
                                                   title: :string,
                                                   content: :text
                                                 }, {
                                                   migrate_data: false,
                                                   remove_source_columns: false
                                                 })
  end

  def down
    rename_column :static_web_contents, :untranslated_content, :content
    rename_column :static_web_contents, :untranslated_title, :title
    Static::WebContent.drop_translation_table! migrate_data: false
  end
end
