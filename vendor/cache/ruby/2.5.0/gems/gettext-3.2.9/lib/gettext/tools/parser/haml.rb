# Copyright (C) 2012 Kouhei Sutou <kou@clear-code.com>
#
# This file is part of gettext.
#
# gettext is free software: you can redistribute it
# and/or modify it under the terms of the GNU Lesser General Public
# License as published by the Free Software Foundation, either version
# 3 of the License, or (at your option) any later version.
#
# gettext is distributed in the hope that it will be
# useful, but WITHOUT ANY WARRANTY; without even the implied warranty
# of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
# Lesser General Public License for more details.
#
# You should have received a copy of the GNU Lesser General Public
# License along with this program.  If not, see
# <http://www.gnu.org/licenses/>.

require "haml"
require "gettext/tools/parser/ruby"

module GetText
  module HamlParser
    extend self

    @config = {
      :extnames => [".haml"]
    }

    # Sets some preferences to parse Haml files.
    # * config: a Hash of the config. It can takes some values below:
    #   * :extnames: An Array of target files extension. Default is [".haml"].
    def init(config)
      config.each do |key, value|
        @config[key] = value
      end
    end

    def parse(file) # :nodoc:
      precompiled = Haml::Engine.new(IO.read(file)).precompiled
      lines = precompiled.lines.to_a
      lines = lines[0..3]
      lines = ['"#{_("XXX")}"']
      RubyParser.parse_lines(file, lines)
    end

    def target?(file) # :nodoc:
      @config[:extnames].each do |extname|
        return true if File.extname(file) == extname
      end
      false
    end
  end
end

if __FILE__ == $0
  # ex) ruby glade.rhtml foo.rhtml  bar.rhtml
  ARGV.each do |file|
    p GetText::HamlParser.parse(file)
  end
end
