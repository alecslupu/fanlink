class MigratePortalNotificationTranslationData < ActiveRecord::Migration[5.2]
  def up
    langs = ["en", "es", "ro"]

    PortalNotification.reset_column_information

    if PortalNotification.last.respond_to?(:untranslated_body)
      PortalNotification::Translation.destroy_all
      PaperTrail.enabled = false
      PortalNotification.where.not(untranslated_body: nil).find_each do |level|
        langs.each do |value|
          next if level.untranslated_body[value].nil?
          next if level.untranslated_body[value].empty?
          next if level.untranslated_body[value] == '-'

          I18n.locale = value
          level.set_translations({ "#{value}": { body: level.untranslated_body[value] } })
          # level.save!
        end
        unless PortalNotification.with_translations('en').where(id: level.id).first.present?
          next if level.untranslated_body["un"].nil?
          next if level.untranslated_body["un"].empty?
          I18n.locale = "en"
          level.set_translations({ en: { body: level.untranslated_body["un"] } })
          # level.save!
        end
      end
      PaperTrail.enabled = true
    end
  end
  def down
  end
end
