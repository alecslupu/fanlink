# -*- encoding: utf-8 -*-
# stub: cucumber-formatter-dots 1.1.0 ruby lib

Gem::Specification.new do |s|
  s.name = "cucumber-formatter-dots".freeze
  s.version = "1.1.0"

  s.required_rubygems_version = Gem::Requirement.new(">= 0".freeze) if s.respond_to? :required_rubygems_version=
  s.require_paths = ["lib".freeze]
  s.authors = ["Matt Wynne".freeze, "Aslak Helles\u00F8y".freeze]
  s.date = "2018-09-29"
  s.description = "Dots formatter for cucumber".freeze
  s.email = "cukes@googlegroups.com".freeze
  s.homepage = "https://github.com/cucumber/dots-formatter-ruby".freeze
  s.licenses = ["MIT".freeze]
  s.rdoc_options = ["--charset=UTF-8".freeze]
  s.required_ruby_version = Gem::Requirement.new(">= 1.9.3".freeze)
  s.rubygems_version = "2.7.6".freeze
  s.summary = "cucumber-formatter-dots-1.1.0".freeze

  s.installed_by_version = "2.7.6" if s.respond_to? :installed_by_version

  if s.respond_to? :specification_version then
    s.specification_version = 4

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_development_dependency(%q<bundler>.freeze, [">= 0"])
      s.add_development_dependency(%q<rake>.freeze, ["~> 10.5"])
      s.add_development_dependency(%q<rspec>.freeze, ["~> 3.7"])
      s.add_runtime_dependency(%q<cucumber-messages>.freeze, [">= 0"])
      s.add_runtime_dependency(%q<os>.freeze, [">= 0"])
    else
      s.add_dependency(%q<bundler>.freeze, [">= 0"])
      s.add_dependency(%q<rake>.freeze, ["~> 10.5"])
      s.add_dependency(%q<rspec>.freeze, ["~> 3.7"])
      s.add_dependency(%q<cucumber-messages>.freeze, [">= 0"])
      s.add_dependency(%q<os>.freeze, [">= 0"])
    end
  else
    s.add_dependency(%q<bundler>.freeze, [">= 0"])
    s.add_dependency(%q<rake>.freeze, ["~> 10.5"])
    s.add_dependency(%q<rspec>.freeze, ["~> 3.7"])
    s.add_dependency(%q<cucumber-messages>.freeze, [">= 0"])
    s.add_dependency(%q<os>.freeze, [">= 0"])
  end
end
