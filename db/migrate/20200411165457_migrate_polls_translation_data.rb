class MigratePollsTranslationData < ActiveRecord::Migration[5.2]
  def up
    if Poll.last.respond_to?(:untranslated_description)
      Poll::Translation.destroy_all
      PaperTrail.enabled = false
      Poll.where.not(untranslated_description: nil).find_each do |poll|
        Migration::PollJob.set(wait_until: 30.minutes.from_now).perform_later(poll.id)
      end
      PaperTrail.enabled = true
    end
  end
  def down
  end
end
