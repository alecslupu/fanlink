class MigratePersonTranslationData < ActiveRecord::Migration[5.2]
  def up

    langs = ["en", "es", "ro"]
    if Person.last.respond_to?(:untranslated_designation)
      Person.where.not(untranslated_designation: nil).find_each do |person|

        langs.each do |value|
          next if person.untranslated_designation[value].nil?
          next if person.untranslated_designation[value].empty?
          next if person.untranslated_designation[value] == '-'

          I18n.locale = value
          person.designation = person.untranslated_designation[value]
          person.save
        end
        unless Person.with_translations('en').where(id: person.id).first.present?
          next if person.untranslated_designation["un"].nil?
          next if person.untranslated_designation["un"].empty?
          I18n.locale = "en"
          person.designation = person.untranslated_designation["un"]
          person.save
        end
      end
    end
  end

  def down
  end
end
