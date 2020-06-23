module Migration
  module Translation
    class LevelJob < ApplicationJob

      queue_as :migration

      def perform(level_id)
        langs = ['en', 'es', 'ro']
        level = Level.find(level_id)
        langs.each do |value|
          return if level.untranslated_name[value].nil?
          return if level.untranslated_name[value].empty?
          return if level.untranslated_name[value] == '-'

          I18n.locale = value
          level.name = level.untranslated_name[value]
          level.description = level.untranslated_description[value]
          level.save
        end
        unless Level.with_translations('en').where(id: level.id).first.present?
          return if level.untranslated_name['un'].nil?
          return if level.untranslated_name['un'].empty?

          I18n.locale = 'en'
          level.name = level.untranslated_name['un']
          level.description = level.untranslated_description['un']
          level.save
        end
      end
    end
  end
end
