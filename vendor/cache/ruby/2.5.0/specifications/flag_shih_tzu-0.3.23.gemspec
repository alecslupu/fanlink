# -*- encoding: utf-8 -*-
# stub: flag_shih_tzu 0.3.23 ruby lib

Gem::Specification.new do |s|
  s.name = "flag_shih_tzu".freeze
  s.version = "0.3.23"

  s.required_rubygems_version = Gem::Requirement.new(">= 0".freeze) if s.respond_to? :required_rubygems_version=
  s.require_paths = ["lib".freeze]
  s.authors = ["Peter Boling".freeze, "Patryk Peszko".freeze, "Sebastian Roebke".freeze, "David Anderson".freeze, "Tim Payton".freeze]
  s.date = "2018-11-30"
  s.description = "Bit fields for ActiveRecord:\nThis gem lets you use a single integer column in an ActiveRecord model\nto store a collection of boolean attributes (flags). Each flag can be used\nalmost in the same way you would use any boolean attribute on an\nActiveRecord object.\n".freeze
  s.email = "peter.boling@gmail.com".freeze
  s.executables = ["test.bash".freeze]
  s.files = ["bin/test.bash".freeze]
  s.homepage = "https://github.com/pboling/flag_shih_tzu".freeze
  s.licenses = ["MIT".freeze]
  s.required_ruby_version = Gem::Requirement.new(">= 1.9.3".freeze)
  s.rubygems_version = "2.7.6".freeze
  s.summary = "Bit fields for ActiveRecord".freeze

  s.installed_by_version = "2.7.6" if s.respond_to? :installed_by_version

  if s.respond_to? :specification_version then
    s.specification_version = 4

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_development_dependency(%q<activerecord>.freeze, [">= 2.3.0"])
      s.add_development_dependency(%q<bundler>.freeze, ["~> 1"])
      s.add_development_dependency(%q<rake>.freeze, [">= 0.9"])
      s.add_development_dependency(%q<rdoc>.freeze, ["~> 5.1"])
      s.add_development_dependency(%q<test-unit>.freeze, ["~> 3"])
      s.add_development_dependency(%q<wwtd>.freeze, ["~> 1"])
    else
      s.add_dependency(%q<activerecord>.freeze, [">= 2.3.0"])
      s.add_dependency(%q<bundler>.freeze, ["~> 1"])
      s.add_dependency(%q<rake>.freeze, [">= 0.9"])
      s.add_dependency(%q<rdoc>.freeze, ["~> 5.1"])
      s.add_dependency(%q<test-unit>.freeze, ["~> 3"])
      s.add_dependency(%q<wwtd>.freeze, ["~> 1"])
    end
  else
    s.add_dependency(%q<activerecord>.freeze, [">= 2.3.0"])
    s.add_dependency(%q<bundler>.freeze, ["~> 1"])
    s.add_dependency(%q<rake>.freeze, [">= 0.9"])
    s.add_dependency(%q<rdoc>.freeze, ["~> 5.1"])
    s.add_dependency(%q<test-unit>.freeze, ["~> 3"])
    s.add_dependency(%q<wwtd>.freeze, ["~> 1"])
  end
end
