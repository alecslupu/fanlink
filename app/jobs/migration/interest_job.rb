class Migration::InterestJob < ApplicationJob
  queue_as :migration

  def perform(interest_id)
    langs = ["en", "es", "ro"]
    interest = Interest.find(interest_id)

    langs.each do |value|
      next if interest.untranslated_title[value].nil?
      next if interest.untranslated_title[value].empty?
      next if interest.untranslated_title[value] == '-'

      I18n.locale = value
      interest.set_translations({ "#{value}": { title: interest.untranslated_title[value] } })
      # level.save!
    end
    unless Interest.with_translations('en').where(id: interest.id).first.present?
      next if interest.untranslated_title["un"].nil?
      next if interest.untranslated_title["un"].empty?
      I18n.locale = "en"
      interest.set_translations({ en: { title: interest.untranslated_title["un"] } })
      # level.save!
    end
  end
end
