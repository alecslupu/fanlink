class MigrateBadgeTranslationData < ActiveRecord::Migration[5.2]
  def up
    langs = ["en", "es", "ro"]

    Badge.reset_column_information

    if Badge.last.respond_to?(:untranslated_name)
      Badge.where.not(untranslated_name: nil).find_each do |level|

        langs.each do |value|
          next if level.untranslated_name[value].nil?
          next if level.untranslated_name[value].empty?
          next if level.untranslated_name[value] == '-'

          begin
            I18n.locale = value
            level.name = level.untranslated_name[value]
            level.save
          rescue ActiveRecord::RecordNotFound
          end
        end
        unless Badge.with_translations('en').where(id: level.id).first.present?
          next if level.untranslated_name["un"].nil?
          next if level.untranslated_name["un"].empty?
          begin
            I18n.locale = "en"
            level.name = level.untranslated_name["un"]
            level.save
          rescue ActiveRecord::RecordNotFound
          end
        end

      end
    end
    if Badge.last.respond_to?(:untranslated_description)
      Badge.where.not(untranslated_description: nil).find_each do |level|

        langs.each do |value|
          next if level.untranslated_description[value].nil?
          next if level.untranslated_description[value].empty?
          next if level.untranslated_description[value] == '-'

          begin
          I18n.locale = value
          level.description = level.untranslated_description[value]
          level.save
          rescue ActiveRecord::RecordNotFound
          end
        end
        unless Badge.with_translations('en').where(id: level.id).first.present?
          next if level.untranslated_description["un"].nil?
          next if level.untranslated_description["un"].empty?
          begin
          I18n.locale = "en"
          level.description = level.untranslated_description["un"]
          level.save
          rescue ActiveRecord::RecordNotFound
          end
        end
      end
    end
  end
  def down

  end
end
