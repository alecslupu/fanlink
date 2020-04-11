class MigrateLevelTranslationData < ActiveRecord::Migration[5.2]
  def up
    langs = ["en", "es", "ro"]

    if Level.last.respond_to?(:untranslated_name)
      Level.where.not(untranslated_name: nil).find_each do |level|

        langs.each do |value|
          next if level.untranslated_name[value].nil?
          next if level.untranslated_name[value].empty?
          next if level.untranslated_name[value] == '-'

          I18n.locale = value
          level.name = level.untranslated_name[value]
          level.save
        end
        unless Level.with_translations('en').where(id: level.id).first.present?
          next if level.untranslated_name["un"].nil?
          next if level.untranslated_name["un"].empty?
          I18n.locale = "en"
          level.name = level.untranslated_name["un"]
          level.save
        end
      end
    end
    if Level.last.respond_to?(:untranslated_description)
      Level.where.not(untranslated_description: nil).find_each do |level|

        langs.each do |value|
          next if level.untranslated_description[value].nil?
          next if level.untranslated_description[value].empty?
          next if level.untranslated_description[value] == '-'

          I18n.locale = value
          level.description = level.untranslated_description[value]
          level.save
        end
        unless Level.with_translations('en').where(id: level.id).first.present?
          next if level.untranslated_description["un"].nil?
          next if level.untranslated_description["un"].empty?
          I18n.locale = "en"
          level.description = level.untranslated_description["un"]
          level.save
        end
      end
    end
  end
  def down

  end
end
