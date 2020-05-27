class MigrateInterestTranslationData < ActiveRecord::Migration[5.2]
  def up

    Interest.reset_column_information

    if Interest.last.respond_to?(:untranslated_title)
      Interest::Translation.destroy_all
      PaperTrail.enabled = false
      Interest.where.not(untranslated_title: nil).find_each do |interest|
        Migration::Translation::InterestJob.set(wait_until: 30.minutes.from_now).perform_later(interest.id)
      end
      PaperTrail.enabled = true
    end
  end
  def down
  end
end
