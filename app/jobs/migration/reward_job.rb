class Migration::RewardJob < ApplicationJob
  queue_as :migration

  def perform(reward_id)
    langs = ["en", "es", "ro"]

    reward = Reward.find(reward_id)

    langs.each do |value|
      next if reward.untranslated_name[value].nil?
      next if reward.untranslated_name[value].empty?
      next if reward.untranslated_name[value] == '-'

      I18n.locale = value
      reward.name = reward.untranslated_name[value]
      reward.save
    end
    unless Reward.with_translations('en').where(id: reward.id).first.present?
      next if reward.untranslated_name["un"].nil?
      next if reward.untranslated_name["un"].empty?
      I18n.locale = "en"
      reward.name = reward.untranslated_name["un"]
      reward.save
    end
  end
end
