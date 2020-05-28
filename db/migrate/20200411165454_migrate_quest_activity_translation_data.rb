class MigrateQuestActivityTranslationData < ActiveRecord::Migration[5.2]
  def up
    QuestActivity.reset_column_information
    if QuestActivity.last.respond_to?(:untranslated_name)
      QuestActivity::Translation.destroy_all
      QuestActivity.where.not(untranslated_name: nil).find_each do |quest_activity|
        Migration::QuestActivityJob.set(wait_until: 30.minutes.from_now).perform_later(quest_activity.id)
      end
    end
  end
  def down

  end
end
