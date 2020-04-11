class MigratePersonTranslationData < ActiveRecord::Migration[5.2]
  def up

    langs = TranslationThings::LANGS.keys - ["un"]
    if Person.respond_to?(:has_manual_translated)
      Person.where.not(untranslated_designation: nil).find_each do |person|

        langs.each do |value|
          next if person.untranslated_designation_to_h[value].nil?
          next if person.untranslated_designation_to_h[value].empty?
          next if person.untranslated_designation_to_h[value] == '-'

          I18n.locale = value
          person.designation = person.untranslated_designation_to_h[value]
          person.save
        end
        unless Person.with_translations('en').where(id: person.id).first.present?
          next if person.untranslated_designation_to_h["un"].nil?
          next if person.untranslated_designation_to_h["un"].empty?
          I18n.locale = "en"
          person.designation = person.untranslated_designation_to_h["un"]
          person.save
        end
      end
    end
  end

  def down
  end
end
