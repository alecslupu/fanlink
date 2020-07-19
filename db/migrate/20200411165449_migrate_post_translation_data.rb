class MigratePostTranslationData < ActiveRecord::Migration[5.2]
  def up
    if Post.last.respond_to?(:untranslated_body)
      Post::Translation.destroy_all
      Post.includes(:person).where.not(untranslated_body: nil).find_each do |post|
        next unless post.person.present?
        Migration::Translation::PostJob.set(wait_until: 30.minutes.from_now).perform_later(post.id)
      end
    end
  end

  def down
  end
end
