# -*- encoding: utf-8 -*-
# stub: jb 0.5.0 ruby lib

Gem::Specification.new do |s|
  s.name = "jb".freeze
  s.version = "0.5.0"

  s.required_rubygems_version = Gem::Requirement.new(">= 0".freeze) if s.respond_to? :required_rubygems_version=
  s.require_paths = ["lib".freeze]
  s.authors = ["Akira Matsuda".freeze]
  s.bindir = "exe".freeze
  s.date = "2017-12-21"
  s.description = "Faster and simpler JSON renderer for Rails".freeze
  s.email = ["ronnie@dio.jp".freeze]
  s.homepage = "https://github.com/amatsuda/jb".freeze
  s.licenses = ["MIT".freeze]
  s.rubygems_version = "2.7.6".freeze
  s.summary = "Faster and simpler Jbuilder alternative".freeze

  s.installed_by_version = "2.7.6" if s.respond_to? :installed_by_version

  if s.respond_to? :specification_version then
    s.specification_version = 4

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_runtime_dependency(%q<multi_json>.freeze, [">= 0"])
      s.add_development_dependency(%q<bundler>.freeze, ["~> 1.12"])
      s.add_development_dependency(%q<rake>.freeze, [">= 0"])
      s.add_development_dependency(%q<test-unit-rails>.freeze, [">= 0"])
      s.add_development_dependency(%q<rails>.freeze, [">= 0"])
      s.add_development_dependency(%q<capybara>.freeze, [">= 0"])
    else
      s.add_dependency(%q<multi_json>.freeze, [">= 0"])
      s.add_dependency(%q<bundler>.freeze, ["~> 1.12"])
      s.add_dependency(%q<rake>.freeze, [">= 0"])
      s.add_dependency(%q<test-unit-rails>.freeze, [">= 0"])
      s.add_dependency(%q<rails>.freeze, [">= 0"])
      s.add_dependency(%q<capybara>.freeze, [">= 0"])
    end
  else
    s.add_dependency(%q<multi_json>.freeze, [">= 0"])
    s.add_dependency(%q<bundler>.freeze, ["~> 1.12"])
    s.add_dependency(%q<rake>.freeze, [">= 0"])
    s.add_dependency(%q<test-unit-rails>.freeze, [">= 0"])
    s.add_dependency(%q<rails>.freeze, [">= 0"])
    s.add_dependency(%q<capybara>.freeze, [">= 0"])
  end
end
