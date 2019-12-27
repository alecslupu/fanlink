# -*- encoding: utf-8 -*-
# stub: administrate-field-belongs_to_search 0.6.0 ruby lib

Gem::Specification.new do |s|
  s.name = "administrate-field-belongs_to_search".freeze
  s.version = "0.6.0"

  s.required_rubygems_version = Gem::Requirement.new(">= 0".freeze) if s.respond_to? :required_rubygems_version=
  s.require_paths = ["lib".freeze]
  s.authors = ["Klas Eskilson".freeze]
  s.date = "2018-07-27"
  s.description = "  Add support to search through (potentially large) belongs_to associations in your Administrate dashboards.\n".freeze
  s.email = ["klas.eskilson@gmail.com".freeze]
  s.homepage = "https://github.com/fishbrain/administrate-field-belongs_to_search".freeze
  s.licenses = ["MIT".freeze]
  s.rubygems_version = "2.7.6".freeze
  s.summary = "Plugin that adds search capabilities to belongs_to associations for Administrate".freeze

  s.installed_by_version = "2.7.6" if s.respond_to? :installed_by_version

  if s.respond_to? :specification_version then
    s.specification_version = 4

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_runtime_dependency(%q<administrate>.freeze, ["< 1.0", ">= 0.3"])
      s.add_runtime_dependency(%q<jbuilder>.freeze, ["~> 2"])
      s.add_runtime_dependency(%q<rails>.freeze, ["< 6.0", ">= 4.2"])
      s.add_runtime_dependency(%q<selectize-rails>.freeze, ["~> 0.6"])
      s.add_development_dependency(%q<coveralls>.freeze, ["~> 0"])
      s.add_development_dependency(%q<factory_girl>.freeze, ["~> 4.8"])
      s.add_development_dependency(%q<rake>.freeze, ["~> 12.0"])
      s.add_development_dependency(%q<rspec>.freeze, ["~> 3.4"])
      s.add_development_dependency(%q<rubocop>.freeze, ["~> 0"])
      s.add_development_dependency(%q<simplecov>.freeze, ["~> 0"])
      s.add_development_dependency(%q<sqlite3>.freeze, ["~> 1.3"])
    else
      s.add_dependency(%q<administrate>.freeze, ["< 1.0", ">= 0.3"])
      s.add_dependency(%q<jbuilder>.freeze, ["~> 2"])
      s.add_dependency(%q<rails>.freeze, ["< 6.0", ">= 4.2"])
      s.add_dependency(%q<selectize-rails>.freeze, ["~> 0.6"])
      s.add_dependency(%q<coveralls>.freeze, ["~> 0"])
      s.add_dependency(%q<factory_girl>.freeze, ["~> 4.8"])
      s.add_dependency(%q<rake>.freeze, ["~> 12.0"])
      s.add_dependency(%q<rspec>.freeze, ["~> 3.4"])
      s.add_dependency(%q<rubocop>.freeze, ["~> 0"])
      s.add_dependency(%q<simplecov>.freeze, ["~> 0"])
      s.add_dependency(%q<sqlite3>.freeze, ["~> 1.3"])
    end
  else
    s.add_dependency(%q<administrate>.freeze, ["< 1.0", ">= 0.3"])
    s.add_dependency(%q<jbuilder>.freeze, ["~> 2"])
    s.add_dependency(%q<rails>.freeze, ["< 6.0", ">= 4.2"])
    s.add_dependency(%q<selectize-rails>.freeze, ["~> 0.6"])
    s.add_dependency(%q<coveralls>.freeze, ["~> 0"])
    s.add_dependency(%q<factory_girl>.freeze, ["~> 4.8"])
    s.add_dependency(%q<rake>.freeze, ["~> 12.0"])
    s.add_dependency(%q<rspec>.freeze, ["~> 3.4"])
    s.add_dependency(%q<rubocop>.freeze, ["~> 0"])
    s.add_dependency(%q<simplecov>.freeze, ["~> 0"])
    s.add_dependency(%q<sqlite3>.freeze, ["~> 1.3"])
  end
end
