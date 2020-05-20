class MigratePollOptionsTranslationData < ActiveRecord::Migration[5.2]
  def up
    if PollOption.last.respond_to?(:untranslated_description)
      PollOption::Translation.destroy_all
      PollOption.where.not(untranslated_description: nil).find_each do |poll_option|
        Migration::PollOptionJob.set(wait_until: 30.minutes.from_now).perform_later(poll_option.id)
      end
    end
  end
  def down
  end
end
