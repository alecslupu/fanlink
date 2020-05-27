class MigrateLevelTranslationData < ActiveRecord::Migration[5.2]
  def up
    if Level.last.respond_to?(:untranslated_name)
      Level::Translation.destroy_all
      Level.where.not(untranslated_name: nil).find_each do |level|
        Migration::Translation::LevelJob.set(wait_until: 30.minutes.from_now).perform_later(level.id)
      end
    end
  end
  def down

  end
end
