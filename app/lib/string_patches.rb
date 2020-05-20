# frozen_string_literal: true
class String
  #
  # Ruby's standard `String#scan` has a somewhat crappy interface: it
  # always wants to give you Arrays of strings. So, if you have a regex
  # that uses named capture groups, `scan` will throw them away. This
  # method is a version of `scan` that works with `MatchData` instances
  # rather than plain old Arrays.
  #
  # @param [Regexp] re
  #   The regex to use for scanning.
  # @return [String, Array<MatchData>]
  #   We return `self` if you pass a block, otherwise we return an Array
  #   of the found `MatchData` objects.
  #
  def scanm(re)
    matches = [ ]
    start   = 0
    while (m = re.match(self, start))
      block_given? ? yield(m) : matches.push(m)
      start = m.end(0)
    end
    block_given? ? self : matches
  end

  #
  # Remove all the accents from a string.
  #
  # @return [String]
  #   This string with the accents removed.
  #
  def de_accent
    #
    # `\p{Mn}` is also known as `\p{Nonspacing_Mark}` but only the short
    # and cryptic form is documented.
    #
    # ActiveSupport::Multibyte::Unicode.normalize(self, :kd).chars.grep(/\p{^Mn}/).join("")
    self.unicode_normalize(:nfkd).chars.grep(/\p{^Mn}/).join("")
  end

  #
  # Mostly Unicode aware version of `upcase`.
  #
  def upcase_u
    UnicodeUtils.simple_upcase(self)
  end

  #
  # Mostly Unicode aware version of `downcase`.
  #
  def downcase_u
    UnicodeUtils.simple_downcase(self)
  end

  def is_integer?
    self.to_i.to_s == self
  end
end
