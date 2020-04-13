class MigratePollOptionsTranslationData < ActiveRecord::Migration[5.2]
  def up
    langs = ["en", "es", "ro"]

    PollOption.reset_column_information

    if PollOption.last.respond_to?(:untranslated_description)
      PollOption::Translation.destroy_all
      PaperTrail.enabled = false
      PollOption.where.not(untranslated_description: nil).find_each do |level|
        langs.each do |value|
          next if level.untranslated_description[value].nil?
          next if level.untranslated_description[value].empty?
          next if level.untranslated_description[value] == '-'

          I18n.locale = value
          level.set_translations({ "#{value}": { description: level.untranslated_description[value] } })
          # level.save!
        end
        unless Poll.with_translations('en').where(id: level.id).first.present?
          next if level.untranslated_description["un"].nil?
          next if level.untranslated_description["un"].empty?
          I18n.locale = "en"
          level.set_translations({ en: { description: level.untranslated_description["un"] } })
          # level.save!
        end
      end
      PaperTrail.enabled = true
    end
  end
  def down
  end
end
