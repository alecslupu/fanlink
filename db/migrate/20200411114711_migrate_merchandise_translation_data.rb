class MigrateMerchandiseTranslationData < ActiveRecord::Migration[5.2]
  def up
    langs = ["en", "es", "ro"]

    Merchandise.reset_column_information

    if Merchandise.last.respond_to?(:untranslated_name)
      Merchandise.where.not(untranslated_name: nil).find_each do |level|
        langs.each do |value|
          next if level.untranslated_name[value].nil?
          next if level.untranslated_name[value].empty?
          next if level.untranslated_name[value] == '-'

          I18n.locale = value
          level.name = level.untranslated_name[value]
          level.description = level.untranslated_description[value]
          level.save!
        end
        unless Merchandise.with_translations('en').where(id: level.id).first.present?
          next if level.untranslated_name["un"].nil?
          next if level.untranslated_name["un"].empty?
          I18n.locale = "en"
          level.name = level.untranslated_name["un"]
          level.description = level.untranslated_description["un"]
          level.save!
        end
      end
    end
  end
  def down
  end
end
