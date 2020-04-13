class MigrateInterestTranslationData < ActiveRecord::Migration[5.2]
  def up
    langs = ["en", "es", "ro"]

    Interest.reset_column_information

    if Interest.last.respond_to?(:untranslated_title)
      Interest::Translation.destroy_all
      PaperTrail.enabled = false
      Interest.where.not(untranslated_title: nil).find_each do |level|
        langs.each do |value|
          next if level.untranslated_title[value].nil?
          next if level.untranslated_title[value].empty?
          next if level.untranslated_title[value] == '-'

          I18n.locale = value
          level.set_translations({ "#{value}": { title: level.untranslated_title[value] } })
          # level.save!
        end
        unless Interest.with_translations('en').where(id: level.id).first.present?
          next if level.untranslated_title["un"].nil?
          next if level.untranslated_title["un"].empty?
          I18n.locale = "en"
          level.set_translations({ en: { title: level.untranslated_title["un"] } })
          # level.save!
        end
      end
      PaperTrail.enabled = true
    end
  end
  def down
  end
end
