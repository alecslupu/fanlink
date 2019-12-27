# -*- encoding: utf-8 -*-
# stub: rest-core 4.0.1 ruby lib

Gem::Specification.new do |s|
  s.name = "rest-core".freeze
  s.version = "4.0.1"

  s.required_rubygems_version = Gem::Requirement.new(">= 0".freeze) if s.respond_to? :required_rubygems_version=
  s.require_paths = ["lib".freeze]
  s.authors = ["Lin Jen-Shin (godfat)".freeze]
  s.date = "2017-05-15"
  s.description = "Various [rest-builder](https://github.com/godfat/rest-builder) middleware\nfor building REST clients.\n\nCheckout [rest-more](https://github.com/godfat/rest-more) for pre-built\nclients.".freeze
  s.email = ["godfat (XD) godfat.org".freeze]
  s.homepage = "https://github.com/godfat/rest-core".freeze
  s.licenses = ["Apache-2.0".freeze]
  s.rubygems_version = "2.7.6".freeze
  s.summary = "Various [rest-builder](https://github.com/godfat/rest-builder) middleware".freeze

  s.installed_by_version = "2.7.6" if s.respond_to? :installed_by_version

  if s.respond_to? :specification_version then
    s.specification_version = 4

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_runtime_dependency(%q<rest-builder>.freeze, [">= 0"])
    else
      s.add_dependency(%q<rest-builder>.freeze, [">= 0"])
    end
  else
    s.add_dependency(%q<rest-builder>.freeze, [">= 0"])
  end
end
