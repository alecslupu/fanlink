module Migration
  module Translation
    class QuestActivityJob < ApplicationJob

      queue_as :migration

      def perform(quest_activity_id)
        langs = ['en', 'es', 'ro']
        quest_activity = QuestActivity.find(quest_activity_id)
        langs.each do |value|
          return if quest_activity.untranslated_name[value].nil?
          return if quest_activity.untranslated_name[value].empty?
          return if quest_activity.untranslated_name[value] == '-'

          I18n.locale = value
          quest_activity.name = quest_activity.untranslated_name[value]
          quest_activity.description = quest_activity.untranslated_description[value]
          quest_activity.hint = quest_activity.untranslated_hint[value]
          quest_activity.title = quest_activity.untranslated_title[value]
          quest_activity.save!
        end
        unless QuestActivity.with_translations('en').where(id: quest_activity.id).first.present?
          return if quest_activity.untranslated_name['un'].nil?
          return if quest_activity.untranslated_name['un'].empty?

          I18n.locale = 'en'
          value = 'un'
          quest_activity.name = quest_activity.untranslated_name[value]
          quest_activity.description = quest_activity.untranslated_description[value]
          quest_activity.hint = quest_activity.untranslated_hint[value]
          quest_activity.title = quest_activity.untranslated_title[value]
          quest_activity.save!
        end
      end
    end
  end
end
