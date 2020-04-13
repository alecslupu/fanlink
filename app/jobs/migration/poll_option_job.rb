class Migration::PollOptionJob < ApplicationJob
  queue_as :migration

  def perform(id)
    langs = ["en", "es", "ro"]
    poll_option = PollOption.find(id)
    langs.each do |value|
      next if poll_option.untranslated_description[value].nil?
      next if poll_option.untranslated_description[value].empty?
      next if poll_option.untranslated_description[value] == '-'

      I18n.locale = value
      poll_option.set_translations({ "#{value}": { description: poll_option.untranslated_description[value] } })
      # level.save!
    end
    unless Poll.with_translations('en').where(id: poll_option.id).first.present?
      next if poll_option.untranslated_description["un"].nil?
      next if poll_option.untranslated_description["un"].empty?
      I18n.locale = "en"
      poll_option.set_translations({ en: { description: poll_option.untranslated_description["un"] } })
      # level.save!
    end

  end
end
