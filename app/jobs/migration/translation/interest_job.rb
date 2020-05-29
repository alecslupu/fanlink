module Migration
  module Translation
    class InterestJob < ApplicationJob
      queue_as :migration

      def perform(interest_id)
        langs = ["en", "es", "ro"]
        interest = Interest.find(interest_id)

        langs.each do |value|
          return if interest.untranslated_title[value].nil?
          return if interest.untranslated_title[value].empty?
          return if interest.untranslated_title[value] == '-'

          I18n.locale = value
          interest.set_translations({ "#{value}": { title: interest.untranslated_title[value] } })
          # level.save!
        end
        unless Interest.with_translations('en').where(id: interest.id).first.present?
          return if interest.untranslated_title["un"].nil?
          return if interest.untranslated_title["un"].empty?
          I18n.locale = "en"
          interest.set_translations({ en: { title: interest.untranslated_title["un"] } })
          # level.save!
        end
      end
    end
  end
end
