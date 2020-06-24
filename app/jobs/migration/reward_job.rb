# frozen_string_literal: true

module  Migration
  class RewardJob < ApplicationJob
    queue_as :migration

    def perform(reward_id)
      langs = ['en', 'es', 'ro']

      reward = Reward.find(reward_id)

      langs.each do |value|
        return if reward.untranslated_name[value].nil?
        return if reward.untranslated_name[value].empty?
        return if reward.untranslated_name[value] == '-'

        I18n.locale = value
        reward.name = reward.untranslated_name[value]
        reward.save
      end
      unless Reward.with_translations('en').where(id: reward.id).first.present?
        return if reward.untranslated_name['un'].nil?
        return if reward.untranslated_name['un'].empty?

        I18n.locale = 'en'
        reward.name = reward.untranslated_name['un']
        reward.save
      end
    end
  end
end
