# -*- encoding: utf-8 -*-
# stub: timber 2.6.1 ruby lib

Gem::Specification.new do |s|
  s.name = "timber".freeze
  s.version = "2.6.1"

  s.required_rubygems_version = Gem::Requirement.new(">= 0".freeze) if s.respond_to? :required_rubygems_version=
  s.require_paths = ["lib".freeze]
  s.authors = ["Timber Technologies, Inc.".freeze]
  s.date = "2017-11-28"
  s.email = ["hi@timber.io".freeze]
  s.executables = ["timber".freeze]
  s.files = ["bin/timber".freeze]
  s.homepage = "https://github.com/timberio/timber-ruby".freeze
  s.required_ruby_version = Gem::Requirement.new(">= 1.9.0".freeze)
  s.rubygems_version = "2.7.6".freeze
  s.summary = "Log Better. Solve Problems Faster. https://timber.io".freeze

  s.installed_by_version = "2.7.6" if s.respond_to? :installed_by_version

  if s.respond_to? :specification_version then
    s.specification_version = 4

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_runtime_dependency(%q<msgpack>.freeze, ["~> 1.0"])
      s.add_development_dependency(%q<bundler-audit>.freeze, [">= 0"])
      s.add_development_dependency(%q<rails_stdout_logging>.freeze, [">= 0"])
      s.add_development_dependency(%q<rake>.freeze, [">= 0"])
      s.add_development_dependency(%q<rspec>.freeze, ["~> 3.4"])
      s.add_development_dependency(%q<rspec-its>.freeze, [">= 0"])
      s.add_development_dependency(%q<timecop>.freeze, [">= 0"])
      s.add_development_dependency(%q<sqlite3>.freeze, [">= 0"])
      s.add_development_dependency(%q<webmock>.freeze, ["~> 2.3"])
    else
      s.add_dependency(%q<msgpack>.freeze, ["~> 1.0"])
      s.add_dependency(%q<bundler-audit>.freeze, [">= 0"])
      s.add_dependency(%q<rails_stdout_logging>.freeze, [">= 0"])
      s.add_dependency(%q<rake>.freeze, [">= 0"])
      s.add_dependency(%q<rspec>.freeze, ["~> 3.4"])
      s.add_dependency(%q<rspec-its>.freeze, [">= 0"])
      s.add_dependency(%q<timecop>.freeze, [">= 0"])
      s.add_dependency(%q<sqlite3>.freeze, [">= 0"])
      s.add_dependency(%q<webmock>.freeze, ["~> 2.3"])
    end
  else
    s.add_dependency(%q<msgpack>.freeze, ["~> 1.0"])
    s.add_dependency(%q<bundler-audit>.freeze, [">= 0"])
    s.add_dependency(%q<rails_stdout_logging>.freeze, [">= 0"])
    s.add_dependency(%q<rake>.freeze, [">= 0"])
    s.add_dependency(%q<rspec>.freeze, ["~> 3.4"])
    s.add_dependency(%q<rspec-its>.freeze, [">= 0"])
    s.add_dependency(%q<timecop>.freeze, [">= 0"])
    s.add_dependency(%q<sqlite3>.freeze, [">= 0"])
    s.add_dependency(%q<webmock>.freeze, ["~> 2.3"])
  end
end
