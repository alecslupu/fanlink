# frozen_string_literal: true

module  Migration
  class PollJob < ApplicationJob
    queue_as :migration

    def perform(poll_id)
      langs = ['en', 'es', 'ro']
      poll = Poll.find(poll_id)

      langs.each do |value|
        return if poll.untranslated_description[value].nil?
        return if poll.untranslated_description[value].empty?
        return if poll.untranslated_description[value] == '-'

        I18n.locale = value
        poll.set_translations({ "#{value}": { description: poll.untranslated_description[value] } })
      end
      unless Poll.with_translations('en').where(id: poll.id).first.present?
        return if poll.untranslated_description['un'].nil?
        return if poll.untranslated_description['un'].empty?

        I18n.locale = 'en'
        poll.set_translations({ en: { description: poll.untranslated_description['un'] } })
      end
    end
  end
end
