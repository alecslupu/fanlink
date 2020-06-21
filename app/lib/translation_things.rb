# frozen_string_literal: true

module TranslationThings
  extend ActiveSupport::Concern

  included do
    include translation_things_module
  end

  LANGS = {
      "un" => "Language Unspecified",
      "en" => "English*",
      # 'ar' => 'Arabic',
      # 'de' => 'German',
      "es" => "Spanish",
      #  'fr' => 'French',
      #  'it' => 'Italian',
      #  'ko' => 'Korean',
      #  'pt' => 'Portuguese',
      "ro" => "Romanian",
  }.freeze

  DEFAULT_LANG = "en"
  DEFAULT_READ_LANG = "en"

  def self.word(code)
    LANGS[code]
  end

  module ClassMethods
    #
    # Mark the named columns as manually translateable. We assume that the named
    # columns are `jsonb` already.
    #
    # For each column, `name`, we will add a `name(language = 'en')`
    # accessor method, a `name=( `:input_lang` || ` `en)` mutator, and an
    # `add_name_translations(hash)` method for merging in a several
    # translations at once.
    #
    # The accessor looks for the translation to the specified language
    # and falls back to `'en'` if necessary.
    #
    # The mutator assumes that you're setting the English version unless
    # the model has an `input_lang` and that is set to something other than English
    #
    # Also note, we override attribute assignment so that we may assign `input_lang`
    # first if it is present.  This ensures the hash is correctly setup.
    #
    def has_manual_translated(*names)
      ActiveSupport::Deprecation.warn("The TranslationThings is deprecated. Please implement Globalize functionality #{caller_locations(1,1)[0].label}")
      add_translation_things_instance_methods_for(names)
    end

  private

    def translation_things_module
      @translation_things_module ||= Module.new
    end

    def add_translation_things_instance_methods_for(names)
      names.each do |name|
        translation_things_module.module_eval(%Q{
          def #{name}(language = DEFAULT_READ_LANG)
            read_attribute(:#{name}).to_h.values_at(language.to_s, DEFAULT_READ_LANG, DEFAULT_LANG, "un").compact.first
          end

          def #{name}_to_h
            read_attribute(:#{name}).to_h
          end

          def #{name}_buffed(language = 'en')
            unbuffed = #{name}(language)
            unbuffed.gsub("{{", "").gsub("}}", "")
          end

          def #{name}=(val)
            h = {}
            Rails.logger.info(val.is_a?(Hash))
            if val.is_a?(String)
              h[DEFAULT_LANG] = val
            elsif val.is_a?(Hash)
              h = val
            end
            if h.empty?
              #{name} = {}
            else
              h.each do |l,v|
                lang = l
                if !LANGS.keys.include?(lang)
                  raise "Unknown language: " + lang
                  lang = 'un'
                end
                if v.blank?
                  write_attribute(:#{name}, read_attribute(:#{name}).to_h.except(lang))
                else
                  write_attribute(:#{name}, read_attribute(:#{name}).to_h.merge({ lang => v }))
                end
              end
            end
          end

          def add_#{name}_translations(values)
            write_attribute(:#{name}, read_attribute(:#{name}).to_h.merge(values.stringify_keys))
          end

          def #{name}_translated?
            raw_hash = self.#{name}_to_h
            if raw_hash.size > 0
              LANGS.keys.each do |l|
                next if l == DEFAULT_LANG
                return true if raw_hash[l].present?
              end
            end
            false
          end
        })

        LANGS.keys.each do |lang|
          translation_things_module.module_eval(%Q{
            def #{name}_#{lang}
              #{name}("#{lang}")
            end

            def #{name}_#{lang}=(val)
              self.#{name} = { "#{lang}" => val }
            end
          })
        end
      end
    end
  end
end
