# frozen_string_literal: true

AttributeNormalizer.configure do |config|
  config.normalizers[:currency] = lambda do |value, options|
    value.is_a?(String) ? value.gsub(/[^0-9\.]+/, '') : value
  end

  config.normalizers[:truncate] = lambda do |text, options|
    if text.is_a?(String)
      options.reverse_merge!(length: 30, omission: '...')
      l = options[:length] - options[:omission].mb_chars.length
      chars = text.mb_chars
      (chars.length > options[:length] ? chars[0...l] + options[:omission] : text).to_s
    else
      text
    end
  end

  config.normalizers[:downcase] = lambda do |value, options|
    value.is_a?(String) ? value.downcase : value
  end

  # The default normalizers if no :with option or block is given is to apply the :strip and :blank normalizers
  # (in that order).
  # You can change this if you would like as follows:
  # config.default_normalizers = :strip, :blank
end
