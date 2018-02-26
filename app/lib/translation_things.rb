module TranslationThings
  extend ActiveSupport::Concern

  included do
    include translation_things_module
  end

  LANGS = {
      'un' => 'Language Unspecified',
      'en' => 'English',
     # 'ar' => 'Arabic',
     # 'de' => 'German',
      'es' => 'Spanish',
    #  'fr' => 'French',
    #  'it' => 'Italian',
    #  'ko' => 'Korean',
    #  'pt' => 'Portuguese',
      'ro' => 'Romanian'
  }.freeze

  DEFAULT_LANG = 'un'

  def self.word(code)
    LANGS[code]
  end

  module ClassMethods
    #
    # Mark the named columns as auto translateable. We assume that the named
    # columns are `jsonb` already.
    #
    # For each column, `name`, we will add a `name(language = 'en')`
    # accessor method, a `name=(en)` mutator, an
    # `add_name_translations(hash)` method for merging in a several
    # translations at once, and an after_save callback to fire up a
    # translation job.
    #
    # The accessor looks for the translation to the specified language
    # and falls back to `'en'` if necessary.
    #
    # The mutator assumes that you're setting the English version.
    #
    def has_auto_translated(*names)
      instance_eval <<-EOE
        after_save :translate_things_if_needed
      EOE
      add_translation_things_instance_methods_for(names)
      add_auto_translation_things_instance_methods_for(names)
    end

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
      add_translation_things_instance_methods_for(names)
    end

    private

    def translation_things_module
      @translation_things_module ||= Module.new
    end

    def add_translation_things_instance_methods_for(names)
      names.each do |name|
        translation_things_module.module_eval(%Q{
          def #{name}(language = DEFAULT_LANG)
            read_attribute(:#{name}).to_h.values_at(language.to_s, DEFAULT_LANG).compact.first
          end

          def #{name}_buffed(language = 'en')
            unbuffed = #{name}(language)
            unbuffed.gsub("{{", "").gsub("}}", "")
          end

          def #{name}=(val)
            h = {}
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
                write_attribute(:#{name}, read_attribute(:#{name}).to_h.merge({ lang => v }))
              end
            end
          end

          def add_#{name}_translations(values)
            write_attribute(:#{name}, read_attribute(:#{name}).to_h.merge(values.stringify_keys))
          end
        })

        LANGS.keys.each do |lang|
          translation_things_module.module_eval(%Q{
            def body_#{lang}
              #{name}(#{lang})
            end

            def body_#{lang}=(val)
              self.#{name} = { "#{lang}" => val }
            end
          })
        end
      end
    end

    def add_auto_translation_things_instance_methods_for(names)
      translation_things_module.module_eval(%Q{

        attr_writer :skip_translation

        def skip_translation
          @skip_translation || false
        end

        def supports_translations_for
          #{names}.map { |n| n.to_s }
        end

        def translation_exception(attribute)
          false
        end


        def assign_attributes(attrs)
          first = attrs.extract!(:input_lang)
          super(first) unless first.empty?
          super(attrs)
        end

      private

        def translate_things_if_needed
          input_lang = self.try(:input_lang) || 'en'
Rails.logger.warn input_lang
          changed = self.changed_attributes.keys & self.supports_translations_for
          if(!changed.empty?)
            attrs = changed.each_with_object({}) do |attr, attrs|
              if !self.translation_exception(attr)
                # new record
                if (self.id_changed?)
                  attrs[attr] = self.attributes[attr][input_lang]
                end

                # updated record
                if(self.changed_attributes[attr] && self.attributes[attr][input_lang] != self.changed_attributes[attr][input_lang])
                  attrs[attr] = self.attributes[attr][input_lang]
                end
              end
              TranslateJob.perform_later(self.id, self.class.name, attrs, input_lang) if (!skip_translation && !attrs.empty?)
            end
          end
        end
      })
    end
  end
end
