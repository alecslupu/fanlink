class AddTranslationPostTable < ActiveRecord::Migration[5.2]
  def up
    unless table_exists?(:post_translations)
      Post.create_translation_table!({
                                       body: :text
                                     }, {
                                       migrate_data: false,
                                       remove_source_columns: false
                                     })
    end
    rename_column :posts, :body, :untranslated_body
  end
  def down
    Post.drop_translation_table! migrate_data: false
  end
end
