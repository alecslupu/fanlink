# -*- encoding: utf-8 -*-
# stub: administrate-field-hidden 0.0.3 ruby lib

Gem::Specification.new do |s|
  s.name = "administrate-field-hidden".freeze
  s.version = "0.0.3"

  s.required_rubygems_version = Gem::Requirement.new(">= 0".freeze) if s.respond_to? :required_rubygems_version=
  s.require_paths = ["lib".freeze]
  s.authors = ["Michele Gerarduzzi".freeze]
  s.date = "2017-04-03"
  s.description = "A plugin for hidden fields in Administrate".freeze
  s.email = ["michele.gerarduzzi@gmail.com".freeze]
  s.homepage = "https://github.com/zooppa/administrate-field-hidden".freeze
  s.licenses = ["MIT".freeze]
  s.rubygems_version = "2.7.6".freeze
  s.summary = "A plugin for hidden fields in Administrate".freeze

  s.installed_by_version = "2.7.6" if s.respond_to? :installed_by_version

  if s.respond_to? :specification_version then
    s.specification_version = 4

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_runtime_dependency(%q<administrate>.freeze, ["< 1.0.0"])
      s.add_runtime_dependency(%q<rails>.freeze, [">= 4.2"])
    else
      s.add_dependency(%q<administrate>.freeze, ["< 1.0.0"])
      s.add_dependency(%q<rails>.freeze, [">= 4.2"])
    end
  else
    s.add_dependency(%q<administrate>.freeze, ["< 1.0.0"])
    s.add_dependency(%q<rails>.freeze, [">= 4.2"])
  end
end
