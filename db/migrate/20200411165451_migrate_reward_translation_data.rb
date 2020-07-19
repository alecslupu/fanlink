class MigrateRewardTranslationData < ActiveRecord::Migration[5.2]
  def up
    if Reward.last.respond_to?(:untranslated_name)
      Reward::Translation.destroy_all
      Reward.where.not(untranslated_name: nil).find_each do |reward|
        Migration::Translation::RewardJob.set(wait_until: 30.minutes.from_now).perform_later(reward.id)
      end
    end
  end
  def down

  end
end
