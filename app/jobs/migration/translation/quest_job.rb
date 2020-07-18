module Migration
  module Translation
    class QuestJob < ApplicationJob
      queue_as :migration

      def perform(quest_id)
        langs = ['en', 'es', 'ro']
        quest = Quest.find(quest_id)
        langs.each do |value|
          return if quest.untranslated_name[value].nil?
          return if quest.untranslated_name[value].empty?
          return if quest.untranslated_name[value] == '-'

          I18n.locale = value
          quest.name = quest.untranslated_name[value]
          quest.description = quest.untranslated_description[value]
          quest.save!
        end
        unless Quest.with_translations('en').where(id: quest.id).first.present?
          return if quest.untranslated_name['un'].nil?
          return if quest.untranslated_name['un'].empty?

          I18n.locale = 'en'
          quest.name = quest.untranslated_name['un']
          quest.description = quest.untranslated_description['un']
          quest.save!
        end
      end
    end
  end
end
