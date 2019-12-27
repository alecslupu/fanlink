# -*- encoding: utf-8 -*-
# stub: wisper-activejob 1.0.0 ruby lib

Gem::Specification.new do |s|
  s.name = "wisper-activejob".freeze
  s.version = "1.0.0"

  s.required_rubygems_version = Gem::Requirement.new(">= 0".freeze) if s.respond_to? :required_rubygems_version=
  s.require_paths = ["lib".freeze]
  s.authors = ["Kris Leech".freeze]
  s.date = "2017-07-28"
  s.description = "Provides Wisper with asynchronous event publishing using ActiveJob".freeze
  s.email = ["kris.leech@gmail.com".freeze]
  s.homepage = "https://github.com/krisleech/wisper-activejob".freeze
  s.licenses = ["MIT".freeze]
  s.required_ruby_version = Gem::Requirement.new(">= 1.9.3".freeze)
  s.rubygems_version = "2.7.6".freeze
  s.summary = "Provides Wisper with asynchronous event publishing using ActiveJob".freeze

  s.installed_by_version = "2.7.6" if s.respond_to? :installed_by_version

  if s.respond_to? :specification_version then
    s.specification_version = 4

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_runtime_dependency(%q<wisper>.freeze, [">= 0"])
      s.add_runtime_dependency(%q<activejob>.freeze, [">= 4.0.0"])
    else
      s.add_dependency(%q<wisper>.freeze, [">= 0"])
      s.add_dependency(%q<activejob>.freeze, [">= 4.0.0"])
    end
  else
    s.add_dependency(%q<wisper>.freeze, [">= 0"])
    s.add_dependency(%q<activejob>.freeze, [">= 4.0.0"])
  end
end
