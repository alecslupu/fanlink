# -*- encoding: utf-8 -*-
# stub: guard-rubycritic 2.9.3 ruby lib

Gem::Specification.new do |s|
  s.name = "guard-rubycritic".freeze
  s.version = "2.9.3"

  s.required_rubygems_version = Gem::Requirement.new(">= 0".freeze) if s.respond_to? :required_rubygems_version=
  s.require_paths = ["lib".freeze]
  s.authors = ["Guilherme Simoes".freeze]
  s.date = "2016-08-22"
  s.description = "    Ruby Critic is a tool that listens to modifications in Ruby classes, modules and methods and\n    reports any new code smells it finds.\n".freeze
  s.email = ["guilherme.rdems@gmail.com".freeze]
  s.homepage = "https://github.com/whitesmith/guard-rubycritic".freeze
  s.licenses = ["MIT".freeze]
  s.rubygems_version = "2.7.6".freeze
  s.summary = "Listens to modifications and detects smells in Ruby files".freeze

  s.installed_by_version = "2.7.6" if s.respond_to? :installed_by_version

  if s.respond_to? :specification_version then
    s.specification_version = 4

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_runtime_dependency(%q<guard>.freeze, ["~> 2.6"])
      s.add_runtime_dependency(%q<rubycritic>.freeze, [">= 2.9.3"])
      s.add_development_dependency(%q<bundler>.freeze, ["~> 1.3"])
      s.add_development_dependency(%q<rake>.freeze, [">= 0"])
      s.add_development_dependency(%q<minitest>.freeze, ["~> 5.3"])
      s.add_development_dependency(%q<mocha>.freeze, ["~> 1.0"])
    else
      s.add_dependency(%q<guard>.freeze, ["~> 2.6"])
      s.add_dependency(%q<rubycritic>.freeze, [">= 2.9.3"])
      s.add_dependency(%q<bundler>.freeze, ["~> 1.3"])
      s.add_dependency(%q<rake>.freeze, [">= 0"])
      s.add_dependency(%q<minitest>.freeze, ["~> 5.3"])
      s.add_dependency(%q<mocha>.freeze, ["~> 1.0"])
    end
  else
    s.add_dependency(%q<guard>.freeze, ["~> 2.6"])
    s.add_dependency(%q<rubycritic>.freeze, [">= 2.9.3"])
    s.add_dependency(%q<bundler>.freeze, ["~> 1.3"])
    s.add_dependency(%q<rake>.freeze, [">= 0"])
    s.add_dependency(%q<minitest>.freeze, ["~> 5.3"])
    s.add_dependency(%q<mocha>.freeze, ["~> 1.0"])
  end
end
