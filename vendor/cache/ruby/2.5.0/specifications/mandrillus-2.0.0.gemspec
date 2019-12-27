# -*- encoding: utf-8 -*-
# stub: mandrillus 2.0.0 ruby lib

Gem::Specification.new do |s|
  s.name = "mandrillus".freeze
  s.version = "2.0.0"

  s.required_rubygems_version = Gem::Requirement.new(">= 0".freeze) if s.respond_to? :required_rubygems_version=
  s.require_paths = ["lib".freeze]
  s.authors = ["Mandrillus Devs".freeze, "Olivier Lacan".freeze]
  s.date = "2018-10-06"
  s.description = "A fork of the official Ruby API library for the Mandrillus email as a service platform.".freeze
  s.email = ["community@mandrill.com".freeze, "hi@olivierlacan.com".freeze]
  s.homepage = "https://github.com/olivierlacan/mandrillus/".freeze
  s.licenses = ["Apache-2.0".freeze]
  s.rubygems_version = "2.7.6".freeze
  s.summary = "A fork of the official Ruby API library for the Mandrillus email as a service platform.".freeze

  s.installed_by_version = "2.7.6" if s.respond_to? :installed_by_version

  if s.respond_to? :specification_version then
    s.specification_version = 4

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_runtime_dependency(%q<json>.freeze, ["< 3.0", ">= 1.7.7"])
      s.add_runtime_dependency(%q<excon>.freeze, ["< 1.0", ">= 0.16.0"])
    else
      s.add_dependency(%q<json>.freeze, ["< 3.0", ">= 1.7.7"])
      s.add_dependency(%q<excon>.freeze, ["< 1.0", ">= 0.16.0"])
    end
  else
    s.add_dependency(%q<json>.freeze, ["< 3.0", ">= 1.7.7"])
    s.add_dependency(%q<excon>.freeze, ["< 1.0", ">= 0.16.0"])
  end
end
