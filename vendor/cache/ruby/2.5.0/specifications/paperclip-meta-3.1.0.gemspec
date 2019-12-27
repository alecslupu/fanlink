# -*- encoding: utf-8 -*-
# stub: paperclip-meta 3.1.0 ruby lib

Gem::Specification.new do |s|
  s.name = "paperclip-meta".freeze
  s.version = "3.1.0"

  s.required_rubygems_version = Gem::Requirement.new(">= 0".freeze) if s.respond_to? :required_rubygems_version=
  s.require_paths = ["lib".freeze]
  s.authors = ["Alexey Bondar".freeze, "Tee Parham".freeze]
  s.date = "2018-05-29"
  s.description = "Add width, height and size methods to paperclip images".freeze
  s.email = ["y8@ya.ru".freeze, "tee@neighborland.com".freeze]
  s.homepage = "http://github.com/teeparham/paperclip-meta".freeze
  s.licenses = ["MIT".freeze]
  s.required_ruby_version = Gem::Requirement.new(">= 2.2.2".freeze)
  s.rubygems_version = "2.7.6".freeze
  s.summary = "Add width, height, and size to paperclip images".freeze

  s.installed_by_version = "2.7.6" if s.respond_to? :installed_by_version

  if s.respond_to? :specification_version then
    s.specification_version = 4

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_runtime_dependency(%q<paperclip>.freeze, [">= 5.0"])
      s.add_development_dependency(%q<bundler>.freeze, ["~> 1.13"])
      s.add_development_dependency(%q<rake>.freeze, ["~> 12.0"])
      s.add_development_dependency(%q<mocha>.freeze, ["~> 1.2"])
      s.add_development_dependency(%q<activerecord>.freeze, ["~> 5.0"])
      s.add_development_dependency(%q<sqlite3>.freeze, [">= 1.3.10"])
      s.add_development_dependency(%q<delayed_paperclip>.freeze, ["~> 3.0"])
      s.add_development_dependency(%q<activesupport>.freeze, ["~> 5.0"])
      s.add_development_dependency(%q<activejob>.freeze, ["~> 5.0"])
      s.add_development_dependency(%q<railties>.freeze, ["~> 5.0"])
    else
      s.add_dependency(%q<paperclip>.freeze, [">= 5.0"])
      s.add_dependency(%q<bundler>.freeze, ["~> 1.13"])
      s.add_dependency(%q<rake>.freeze, ["~> 12.0"])
      s.add_dependency(%q<mocha>.freeze, ["~> 1.2"])
      s.add_dependency(%q<activerecord>.freeze, ["~> 5.0"])
      s.add_dependency(%q<sqlite3>.freeze, [">= 1.3.10"])
      s.add_dependency(%q<delayed_paperclip>.freeze, ["~> 3.0"])
      s.add_dependency(%q<activesupport>.freeze, ["~> 5.0"])
      s.add_dependency(%q<activejob>.freeze, ["~> 5.0"])
      s.add_dependency(%q<railties>.freeze, ["~> 5.0"])
    end
  else
    s.add_dependency(%q<paperclip>.freeze, [">= 5.0"])
    s.add_dependency(%q<bundler>.freeze, ["~> 1.13"])
    s.add_dependency(%q<rake>.freeze, ["~> 12.0"])
    s.add_dependency(%q<mocha>.freeze, ["~> 1.2"])
    s.add_dependency(%q<activerecord>.freeze, ["~> 5.0"])
    s.add_dependency(%q<sqlite3>.freeze, [">= 1.3.10"])
    s.add_dependency(%q<delayed_paperclip>.freeze, ["~> 3.0"])
    s.add_dependency(%q<activesupport>.freeze, ["~> 5.0"])
    s.add_dependency(%q<activejob>.freeze, ["~> 5.0"])
    s.add_dependency(%q<railties>.freeze, ["~> 5.0"])
  end
end
