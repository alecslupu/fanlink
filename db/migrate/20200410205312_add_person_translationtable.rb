class AddPersonTranslationtable < ActiveRecord::Migration[5.2]
  def up
    unless table_exists?(:person_translations)
      Person.create_translation_table!({
                                       designation: :text
                                     }, {
                                       migrate_data: false,
                                       remove_source_columns: false
                                     })
    end
    rename_column :people, :designation, :untranslated_designation
  end
  def down
    Person.drop_translation_table! migrate_data: false
  end
end
