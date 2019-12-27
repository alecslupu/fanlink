# -*- encoding: utf-8 -*-
# stub: jko_api 0.2.7.0 ruby lib

Gem::Specification.new do |s|
  s.name = "jko_api".freeze
  s.version = "0.2.7.0"

  s.required_rubygems_version = Gem::Requirement.new(">= 0".freeze) if s.respond_to? :required_rubygems_version=
  s.require_paths = ["lib".freeze]
  s.authors = ["Jeremy Woertink".freeze]
  s.date = "2018-03-26"
  s.description = "Some Rails API code written by JustinKo and ported to a badly written gem".freeze
  s.email = ["jeremywoertink@gmail.com".freeze]
  s.homepage = "https://github.com/jwoertink/jko_api".freeze
  s.licenses = ["MIT".freeze]
  s.rubygems_version = "2.7.6".freeze
  s.summary = "A Rails API gem".freeze

  s.installed_by_version = "2.7.6" if s.respond_to? :installed_by_version

  if s.respond_to? :specification_version then
    s.specification_version = 4

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_development_dependency(%q<bundler>.freeze, [">= 1.7"])
      s.add_development_dependency(%q<rake>.freeze, [">= 10.0"])
      s.add_runtime_dependency(%q<responders>.freeze, ["= 2.4.0"])
      s.add_runtime_dependency(%q<rails>.freeze, ["<= 5.1.4", ">= 4.2.7"])
      s.add_runtime_dependency(%q<warden-oauth2>.freeze, [">= 0"])
    else
      s.add_dependency(%q<bundler>.freeze, [">= 1.7"])
      s.add_dependency(%q<rake>.freeze, [">= 10.0"])
      s.add_dependency(%q<responders>.freeze, ["= 2.4.0"])
      s.add_dependency(%q<rails>.freeze, ["<= 5.1.4", ">= 4.2.7"])
      s.add_dependency(%q<warden-oauth2>.freeze, [">= 0"])
    end
  else
    s.add_dependency(%q<bundler>.freeze, [">= 1.7"])
    s.add_dependency(%q<rake>.freeze, [">= 10.0"])
    s.add_dependency(%q<responders>.freeze, ["= 2.4.0"])
    s.add_dependency(%q<rails>.freeze, ["<= 5.1.4", ">= 4.2.7"])
    s.add_dependency(%q<warden-oauth2>.freeze, [">= 0"])
  end
end
