module Migration
  class PersonJob < ApplicationJob
    queue_as :migration

    def perform(person_id)

      langs = ["en", "es", "ro"]
      person = Person.find(person_id)
      langs.each do |value|
        return if person.untranslated_designation[value].nil?
        return if person.untranslated_designation[value].empty?
        return if person.untranslated_designation[value] == '-'

        I18n.locale = value
        person.designation = person.untranslated_designation[value]
        person.save
      end
      unless Person.with_translations('en').where(id: person.id).first.present?
        return if person.untranslated_designation["un"].nil?
        return if person.untranslated_designation["un"].empty?
        I18n.locale = "en"
        person.designation = person.untranslated_designation["un"]
        person.save
      end
    end
  end
end
