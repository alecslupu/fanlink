class AddTranslationTableForStaticSystemEmails < ActiveRecord::Migration[5.2]
  def up
    Static::SystemEmail.create_translation_table!({
      html_template: :text,
      text_template: :text,
      subject: :string
    }, {
      migrate_data: false,
      remove_source_columns: false
    })
  end

  def down
    Static::SystemEmail.drop_translation_table! migrate_data: false
  end
end
