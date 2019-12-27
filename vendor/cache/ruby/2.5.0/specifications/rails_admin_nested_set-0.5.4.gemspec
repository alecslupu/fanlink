# -*- encoding: utf-8 -*-
# stub: rails_admin_nested_set 0.5.4 ruby lib

Gem::Specification.new do |s|
  s.name = "rails_admin_nested_set".freeze
  s.version = "0.5.4"

  s.required_rubygems_version = Gem::Requirement.new(">= 0".freeze) if s.respond_to? :required_rubygems_version=
  s.require_paths = ["lib".freeze]
  s.authors = ["Gleb Tv".freeze]
  s.date = "2018-05-26"
  s.description = "Rails admin nested set".freeze
  s.email = ["glebtv@gmail.com".freeze]
  s.homepage = "https://github.com/rs-pro/rails_admin_nested_set".freeze
  s.rubygems_version = "2.7.6".freeze
  s.summary = "Interface for editing a nested set for rails_admin".freeze

  s.installed_by_version = "2.7.6" if s.respond_to? :installed_by_version

  if s.respond_to? :specification_version then
    s.specification_version = 4

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_runtime_dependency(%q<rails_admin>.freeze, [">= 0"])
      s.add_runtime_dependency(%q<rails>.freeze, [">= 4.1.0"])
    else
      s.add_dependency(%q<rails_admin>.freeze, [">= 0"])
      s.add_dependency(%q<rails>.freeze, [">= 4.1.0"])
    end
  else
    s.add_dependency(%q<rails_admin>.freeze, [">= 0"])
    s.add_dependency(%q<rails>.freeze, [">= 4.1.0"])
  end
end
