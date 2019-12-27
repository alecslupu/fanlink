# -*- encoding: utf-8 -*-
# stub: acts_as_api 1.0.1 ruby lib

Gem::Specification.new do |s|
  s.name = "acts_as_api".freeze
  s.version = "1.0.1"

  s.required_rubygems_version = Gem::Requirement.new(">= 0".freeze) if s.respond_to? :required_rubygems_version=
  s.require_paths = ["lib".freeze]
  s.authors = ["Christian B\u00E4uerlein".freeze]
  s.date = "2017-08-04"
  s.description = "acts_as_api enriches the models and controllers of your app in a rails-like way so you can easily determine how your XML/JSON API responses should look like.".freeze
  s.email = ["christian@ffwdme.com".freeze]
  s.homepage = "https://github.com/fabrik42/acts_as_api".freeze
  s.rdoc_options = ["--charset=UTF-8".freeze]
  s.rubygems_version = "2.7.6".freeze
  s.summary = "Makes creating XML/JSON responses in Rails 3, 4 and 5 easy and fun.".freeze

  s.installed_by_version = "2.7.6" if s.respond_to? :installed_by_version

  if s.respond_to? :specification_version then
    s.specification_version = 4

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_runtime_dependency(%q<activemodel>.freeze, [">= 3.0.0"])
      s.add_runtime_dependency(%q<activesupport>.freeze, [">= 3.0.0"])
      s.add_runtime_dependency(%q<rack>.freeze, [">= 1.1.0"])
      s.add_development_dependency(%q<rails>.freeze, [">= 3.2.22.2"])
      s.add_development_dependency(%q<mongoid>.freeze, [">= 3.0.1"])
      s.add_development_dependency(%q<rocco>.freeze, [">= 0.8.0"])
    else
      s.add_dependency(%q<activemodel>.freeze, [">= 3.0.0"])
      s.add_dependency(%q<activesupport>.freeze, [">= 3.0.0"])
      s.add_dependency(%q<rack>.freeze, [">= 1.1.0"])
      s.add_dependency(%q<rails>.freeze, [">= 3.2.22.2"])
      s.add_dependency(%q<mongoid>.freeze, [">= 3.0.1"])
      s.add_dependency(%q<rocco>.freeze, [">= 0.8.0"])
    end
  else
    s.add_dependency(%q<activemodel>.freeze, [">= 3.0.0"])
    s.add_dependency(%q<activesupport>.freeze, [">= 3.0.0"])
    s.add_dependency(%q<rack>.freeze, [">= 1.1.0"])
    s.add_dependency(%q<rails>.freeze, [">= 3.2.22.2"])
    s.add_dependency(%q<mongoid>.freeze, [">= 3.0.1"])
    s.add_dependency(%q<rocco>.freeze, [">= 0.8.0"])
  end
end
