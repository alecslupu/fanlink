# frozen_string_literal: true

module RailsAdmin
  module Config
    module Fields
      module Types
        class Translated < RailsAdmin::Config::Fields::Base
          RailsAdmin::Config::Fields::Types.register(self)

          def initialize(parent, name, properties)
            properties = parent.abstract_model.associations.detect {|p| name == p.name}
            super
          end

          register_instance_option :partial do
            :form_translated_tabs
          end

          def generic_help
            '' # false is ignored by I18n.translate
          end

          # Reader for validation errors of the bound object
          def errors
            bindings[:object].errors[name]
          end

          def available_locales
            TranslationThings::LANGS
          end

          def current_locale
            # I18n.locale
            TranslationThings::DEFAULT_LANG
          end


          # Returns array of Translation objects.
          # It gets existing or creates new empty translation for every locale.
          # Call the first time with reset_cache == true to update memoized translations.
          def translations reset_cache = false
            # return @translations if @translations && !reset_cache
            #
            # translations = @bindings[:object].translations_by_locale
            # new_locales = available_locales - translations.keys.map(&:to_sym)
            #
            # new_locales.map do |locale|
            #   translations[locale] = @bindings[:object].translations.new({locale: locale})
            # end
            #
            # @translations = translations
          end
        end
      end
    end
  end
end
