# -*- encoding: utf-8 -*-
# stub: postgresql-check 0.1.3 ruby lib

Gem::Specification.new do |s|
  s.name = "postgresql-check".freeze
  s.version = "0.1.3"

  s.required_rubygems_version = Gem::Requirement.new(">= 0".freeze) if s.respond_to? :required_rubygems_version=
  s.require_paths = ["lib".freeze]
  s.authors = ["Alexei Mikhailov".freeze]
  s.date = "2017-05-26"
  s.email = ["amikhailov83@gmail.com".freeze]
  s.homepage = "https://github.com/take-five/postgresql-check".freeze
  s.licenses = ["MIT".freeze]
  s.rubygems_version = "2.7.6".freeze
  s.summary = "Adds helpers to migrations and dumps check constraints to schema.rb".freeze

  s.installed_by_version = "2.7.6" if s.respond_to? :installed_by_version

  if s.respond_to? :specification_version then
    s.specification_version = 4

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_runtime_dependency(%q<activerecord>.freeze, [">= 3.2.0"])
      s.add_development_dependency(%q<bundler>.freeze, ["~> 1.7"])
      s.add_development_dependency(%q<rake>.freeze, ["~> 10.0"])
    else
      s.add_dependency(%q<activerecord>.freeze, [">= 3.2.0"])
      s.add_dependency(%q<bundler>.freeze, ["~> 1.7"])
      s.add_dependency(%q<rake>.freeze, ["~> 10.0"])
    end
  else
    s.add_dependency(%q<activerecord>.freeze, [">= 3.2.0"])
    s.add_dependency(%q<bundler>.freeze, ["~> 1.7"])
    s.add_dependency(%q<rake>.freeze, ["~> 10.0"])
  end
end
