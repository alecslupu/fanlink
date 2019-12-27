# -*- encoding: utf-8 -*-
# stub: acts_as_tenant 0.4.3 ruby lib

Gem::Specification.new do |s|
  s.name = "acts_as_tenant".freeze
  s.version = "0.4.3"

  s.required_rubygems_version = Gem::Requirement.new(">= 0".freeze) if s.respond_to? :required_rubygems_version=
  s.require_paths = ["lib".freeze]
  s.authors = ["Erwin Matthijssen".freeze]
  s.date = "2018-03-29"
  s.description = "Integrates multi-tenancy into a Rails application in a convenient and out-of-your way manner".freeze
  s.email = ["erwin.matthijssen@gmail.com".freeze]
  s.homepage = "http://www.rollcallapp.com/blog".freeze
  s.rubyforge_project = "acts_as_tenant".freeze
  s.rubygems_version = "2.7.6".freeze
  s.summary = "Add multi-tenancy to Rails applications using a shared db strategy".freeze

  s.installed_by_version = "2.7.6" if s.respond_to? :installed_by_version

  if s.respond_to? :specification_version then
    s.specification_version = 4

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_runtime_dependency(%q<request_store>.freeze, [">= 1.0.5"])
      s.add_runtime_dependency(%q<rails>.freeze, [">= 4.0"])
      s.add_development_dependency(%q<rspec>.freeze, [">= 3.0"])
      s.add_development_dependency(%q<rspec-rails>.freeze, [">= 0"])
      s.add_development_dependency(%q<database_cleaner>.freeze, ["~> 1.5.3"])
      s.add_development_dependency(%q<sqlite3>.freeze, [">= 0"])
      s.add_development_dependency(%q<sidekiq>.freeze, ["= 3.2.1"])
    else
      s.add_dependency(%q<request_store>.freeze, [">= 1.0.5"])
      s.add_dependency(%q<rails>.freeze, [">= 4.0"])
      s.add_dependency(%q<rspec>.freeze, [">= 3.0"])
      s.add_dependency(%q<rspec-rails>.freeze, [">= 0"])
      s.add_dependency(%q<database_cleaner>.freeze, ["~> 1.5.3"])
      s.add_dependency(%q<sqlite3>.freeze, [">= 0"])
      s.add_dependency(%q<sidekiq>.freeze, ["= 3.2.1"])
    end
  else
    s.add_dependency(%q<request_store>.freeze, [">= 1.0.5"])
    s.add_dependency(%q<rails>.freeze, [">= 4.0"])
    s.add_dependency(%q<rspec>.freeze, [">= 3.0"])
    s.add_dependency(%q<rspec-rails>.freeze, [">= 0"])
    s.add_dependency(%q<database_cleaner>.freeze, ["~> 1.5.3"])
    s.add_dependency(%q<sqlite3>.freeze, [">= 0"])
    s.add_dependency(%q<sidekiq>.freeze, ["= 3.2.1"])
  end
end
