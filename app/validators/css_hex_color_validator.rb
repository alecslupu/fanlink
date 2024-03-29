# frozen_string_literal: true

class CssHexColorValidator < ActiveModel::EachValidator
  def validate_each(object, attribute, value)
    unless /^#([A-Fa-f0-9]{6}[0-9]{2}|[A-Fa-f0-9]{6}|[A-Fa-f0-9]{3})$/i.match?(value)
      object.errors[attribute] << (options[:message] || 'must be a valid CSS hex color code')
    end
  end
end
