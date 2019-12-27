# -*- encoding: utf-8 -*-
# stub: wisper-activerecord 1.0.0 ruby lib

Gem::Specification.new do |s|
  s.name = "wisper-activerecord".freeze
  s.version = "1.0.0"

  s.required_rubygems_version = Gem::Requirement.new(">= 0".freeze) if s.respond_to? :required_rubygems_version=
  s.require_paths = ["lib".freeze]
  s.authors = ["Kris Leech".freeze]
  s.date = "2017-05-19"
  s.description = "Subscribe to changes on ActiveRecord models".freeze
  s.email = ["kris.leech@gmail.com".freeze]
  s.homepage = "https://github.com/krisleech/wisper-activerecord".freeze
  s.licenses = ["MIT".freeze]
  s.required_ruby_version = Gem::Requirement.new(">= 1.9.3".freeze)
  s.rubygems_version = "2.7.6".freeze
  s.summary = "Subscribe to changes on ActiveRecord models".freeze

  s.installed_by_version = "2.7.6" if s.respond_to? :installed_by_version

  if s.respond_to? :specification_version then
    s.specification_version = 4

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_runtime_dependency(%q<wisper>.freeze, ["~> 2.0"])
      s.add_runtime_dependency(%q<activerecord>.freeze, [">= 3.0.0"])
    else
      s.add_dependency(%q<wisper>.freeze, ["~> 2.0"])
      s.add_dependency(%q<activerecord>.freeze, [">= 3.0.0"])
    end
  else
    s.add_dependency(%q<wisper>.freeze, ["~> 2.0"])
    s.add_dependency(%q<activerecord>.freeze, [">= 3.0.0"])
  end
end
