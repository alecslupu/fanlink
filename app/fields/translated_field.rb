require "administrate/field/base"
class TranslatedField < Administrate::Field::Base
  def self.permitted_attribute(attr)
    attributes = []
    TranslationThings::LANGS.keys.each do |l|
      attributes << "#{attr}_#{l}"
    end
    attributes
  end
end
