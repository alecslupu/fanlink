class AddPortalNotificationTranslationsTable < ActiveRecord::Migration[5.2]
  def up
    unless table_exists?(:portal_notification_translations)
      PortalNotification.create_translation_table!({
                                             body: :text,
                                         }, {
                                           migrate_data: false,
                                           remove_source_columns: false
                                         })
    end
    rename_column :portal_notifications, :body, :untranslated_body
  end

  def down
    rename_column :portal_notifications, :untranslated_body, :body
    PortalNotification.drop_translation_table! migrate_data: false
  end
end
