class MigrateBadgeTranslationData < ActiveRecord::Migration[5.2]
  def up
    if Badge.last.respond_to?(:untranslated_name)
      Badge::Translation.destroy_all
      Badge.where.not(untranslated_name: nil).find_each do |badge|
        Migration::Translation::BadgeJob.set(wait_until: 30.minutes.from_now ).perform_later(badge.id)
      end
    end
  end
  def down

  end
end
