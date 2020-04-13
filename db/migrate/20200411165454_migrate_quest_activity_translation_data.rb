class MigrateQuestActivityTranslationData < ActiveRecord::Migration[5.2]
  def up
    langs = ["en", "es", "ro"]

    QuestActivity.reset_column_information

    if QuestActivity.last.respond_to?(:untranslated_name)
      QuestActivity::Translation.destroy_all
      PaperTrail.enabled = false
      QuestActivity.where.not(untranslated_name: nil).find_each do |level|
        langs.each do |value|
          next if level.untranslated_name[value].nil?
          next if level.untranslated_name[value].empty?
          next if level.untranslated_name[value] == '-'

          I18n.locale = value
          level.name = level.untranslated_name[value]
          level.description = level.untranslated_description[value]
          level.hint = level.untranslated_hint[value]
          level.title = level.untranslated_title[value]
          level.save!
        end
        unless QuestActivity.with_translations('en').where(id: level.id).first.present?
          next if level.untranslated_name["un"].nil?
          next if level.untranslated_name["un"].empty?
          I18n.locale = "en"
          value = "un"
          level.name = level.untranslated_name[value]
          level.description = level.untranslated_description[value]
          level.hint = level.untranslated_hint[value]
          level.title = level.untranslated_title[value]
          level.save!
        end
      end
      PaperTrail.enabled = true
    end
  end
  def down

  end
end
