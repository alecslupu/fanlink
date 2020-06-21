class Migration::BadgeJob < ApplicationJob
  queue_as :migration

  def perform(badge_id)
    langs = ['en', 'es', 'ro']

    badge = Badge.find(badge_id)
    langs.each do |value|
      return if badge.untranslated_name[value].nil?
      return if badge.untranslated_name[value].empty?
      return if badge.untranslated_name[value] == '-'

      begin
        I18n.locale = value
        badge.name = badge.untranslated_name[value]
        badge.description = badge.untranslated_description[value]
        badge.save
      rescue ActiveRecord::RecordNotFound
      end
    end
    unless Badge.with_translations('en').where(id: badge.id).first.present?
      return if badge.untranslated_name['un'].nil?
      return if badge.untranslated_name['un'].empty?
      begin
        I18n.locale = 'en'
        badge.name = badge.untranslated_name['un']
        badge.description = badge.untranslated_description['un']
        badge.save
      rescue ActiveRecord::RecordNotFound
      end
    end
  end
end
