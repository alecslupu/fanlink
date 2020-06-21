# frozen_string_literal: true

#
# Some string wrangling utilities that we don't want to patch into
# `String`.
#
module StringUtil
  #
  # Normalize a string for various simple searches. We downcase the
  # string (in a Unicode-aware but not locale-aware way), strip off
  # accents, and remove non-alphanumerics.
  #
  # @param [String] s
  #   The string to cleanup. We will do the Right Thing with a `nil`.
  # @return [String]
  #   The cleaned up string.
  #
  def self.search_ify(s)
    s.to_s.downcase_u.de_accent.gsub(/\p{^Alnum}/, "")
  end

  #
  # Return a URL-safe version of a string, we'll take care of everything
  # so you can just slop the returned string into a URL path and not
  # worry about it.
  #
  # @param [String] s
  #   The string to mangle.
  # @return [String]
  #   A URL-safe and SEO-friendly version of the string.
  #
  def self.url_ify(s)
    CGI.escape(s.de_accent.gsub(/\s+/, "-"))
  end

  #
  #  Returns the string with our tags stripped out.
  def self.tag_cleaner(s)
  end
end
