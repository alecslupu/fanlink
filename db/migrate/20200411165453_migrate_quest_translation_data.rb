class MigrateQuestTranslationData < ActiveRecord::Migration[5.2]
  def up
    if Quest.last.respond_to?(:untranslated_name)
      Quest::Translation.destroy_all
      Quest.where.not(untranslated_name: nil).find_each do |quest|
        Migration::Translation::QuestJob.set(wait_until: 30.minutes.from_now).perform_later(quest.id)
      end
    end
  end
  def down

  end
end
