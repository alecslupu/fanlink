# -*- encoding: utf-8 -*-
# stub: gherkin 6.0.17 ruby lib

Gem::Specification.new do |s|
  s.name = "gherkin".freeze
  s.version = "6.0.17"

  s.required_rubygems_version = Gem::Requirement.new(">= 0".freeze) if s.respond_to? :required_rubygems_version=
  s.metadata = { "bug_tracker_uri" => "https://github.com/cucumber/cucumber/issues", "changelog_uri" => "https://github.com/cucumber/cucumber/blob/master/gherkin/CHANGELOG.md", "documentation_uri" => "https://docs.cucumber.io/gherkin/", "mailing_list_uri" => "https://groups.google.com/forum/#!forum/cukes", "source_code_uri" => "https://github.com/cucumber/cucumber/blob/master/gherkin/ruby" } if s.respond_to? :metadata=
  s.require_paths = ["lib".freeze]
  s.authors = ["G\u00E1sp\u00E1r Nagy".freeze, "Aslak Helles\u00F8y".freeze, "Steve Tooke".freeze]
  s.date = "2019-03-31"
  s.description = "Gherkin parser".freeze
  s.email = "cukes@googlegroups.com".freeze
  s.executables = ["gherkin-ruby".freeze, "gherkin".freeze]
  s.files = ["bin/gherkin".freeze, "bin/gherkin-ruby".freeze]
  s.homepage = "https://github.com/cucumber/gherkin-ruby".freeze
  s.licenses = ["MIT".freeze]
  s.rdoc_options = ["--charset=UTF-8".freeze]
  s.required_ruby_version = Gem::Requirement.new(">= 2.3".freeze)
  s.rubygems_version = "2.7.6".freeze
  s.summary = "gherkin-6.0.17".freeze

  s.installed_by_version = "2.7.6" if s.respond_to? :installed_by_version

  if s.respond_to? :specification_version then
    s.specification_version = 4

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_runtime_dependency(%q<c21e>.freeze, ["~> 1.1.9"])
      s.add_runtime_dependency(%q<cucumber-messages>.freeze, ["~> 2.1.2"])
      s.add_development_dependency(%q<bundler>.freeze, [">= 0"])
      s.add_development_dependency(%q<rake>.freeze, ["~> 10.5"])
      s.add_development_dependency(%q<rspec>.freeze, ["~> 3.7"])
      s.add_development_dependency(%q<coveralls>.freeze, [">= 0"])
    else
      s.add_dependency(%q<c21e>.freeze, ["~> 1.1.9"])
      s.add_dependency(%q<cucumber-messages>.freeze, ["~> 2.1.2"])
      s.add_dependency(%q<bundler>.freeze, [">= 0"])
      s.add_dependency(%q<rake>.freeze, ["~> 10.5"])
      s.add_dependency(%q<rspec>.freeze, ["~> 3.7"])
      s.add_dependency(%q<coveralls>.freeze, [">= 0"])
    end
  else
    s.add_dependency(%q<c21e>.freeze, ["~> 1.1.9"])
    s.add_dependency(%q<cucumber-messages>.freeze, ["~> 2.1.2"])
    s.add_dependency(%q<bundler>.freeze, [">= 0"])
    s.add_dependency(%q<rake>.freeze, ["~> 10.5"])
    s.add_dependency(%q<rspec>.freeze, ["~> 3.7"])
    s.add_dependency(%q<coveralls>.freeze, [">= 0"])
  end
end
