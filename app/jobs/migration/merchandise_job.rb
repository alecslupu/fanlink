# frozen_string_literal: true

module  Migration
  class MerchandiseJob < ApplicationJob
    queue_as :migration

    def perform(merchandise_id)
      langs = ['en', 'es', 'ro']
      merchandise = Merchandise.find(merchandise_id)
      langs.each do |value|
        return if merchandise.untranslated_name[value].nil?
        return if merchandise.untranslated_name[value].empty?
        return if merchandise.untranslated_name[value] == '-'

        I18n.locale = value
        merchandise.name = merchandise.untranslated_name[value]
        merchandise.description = merchandise.untranslated_description[value]
        merchandise.save!
      end
      unless Merchandise.with_translations('en').where(id: merchandise.id).first.present?
        return if merchandise.untranslated_name['un'].nil?
        return if merchandise.untranslated_name['un'].empty?
        I18n.locale = 'en'
        merchandise.name = merchandise.untranslated_name['un']
        merchandise.description = merchandise.untranslated_description['un']
        merchandise.save!
      end
    end
  end
end
