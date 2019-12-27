# -*- encoding: utf-8 -*-
# stub: mandrill_mailer 1.6.0 ruby lib

Gem::Specification.new do |s|
  s.name = "mandrill_mailer".freeze
  s.version = "1.6.0"

  s.required_rubygems_version = Gem::Requirement.new(">= 0".freeze) if s.respond_to? :required_rubygems_version=
  s.require_paths = ["lib".freeze]
  s.authors = ["Adam Rensel".freeze]
  s.date = "2017-03-23"
  s.description = "Transactional Mailer for Mandrill".freeze
  s.email = ["adamrensel@codeschool.com".freeze]
  s.homepage = "https://github.com/renz45/mandrill_mailer".freeze
  s.licenses = ["MIT".freeze]
  s.rubygems_version = "2.7.6".freeze
  s.summary = "Transactional Mailer for Mandrill".freeze

  s.installed_by_version = "2.7.6" if s.respond_to? :installed_by_version

  if s.respond_to? :specification_version then
    s.specification_version = 4

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_runtime_dependency(%q<activesupport>.freeze, [">= 0"])
      s.add_runtime_dependency(%q<actionpack>.freeze, [">= 0"])
      s.add_runtime_dependency(%q<activejob>.freeze, [">= 0"])
      s.add_runtime_dependency(%q<mandrill-api>.freeze, ["~> 1.0.9"])
      s.add_development_dependency(%q<pry>.freeze, [">= 0"])
      s.add_development_dependency(%q<rspec>.freeze, [">= 0"])
    else
      s.add_dependency(%q<activesupport>.freeze, [">= 0"])
      s.add_dependency(%q<actionpack>.freeze, [">= 0"])
      s.add_dependency(%q<activejob>.freeze, [">= 0"])
      s.add_dependency(%q<mandrill-api>.freeze, ["~> 1.0.9"])
      s.add_dependency(%q<pry>.freeze, [">= 0"])
      s.add_dependency(%q<rspec>.freeze, [">= 0"])
    end
  else
    s.add_dependency(%q<activesupport>.freeze, [">= 0"])
    s.add_dependency(%q<actionpack>.freeze, [">= 0"])
    s.add_dependency(%q<activejob>.freeze, [">= 0"])
    s.add_dependency(%q<mandrill-api>.freeze, ["~> 1.0.9"])
    s.add_dependency(%q<pry>.freeze, [">= 0"])
    s.add_dependency(%q<rspec>.freeze, [">= 0"])
  end
end
