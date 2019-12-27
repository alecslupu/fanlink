# -*- encoding: utf-8 -*-
# stub: guard-annotate 2.3 ruby lib

Gem::Specification.new do |s|
  s.name = "guard-annotate".freeze
  s.version = "2.3"

  s.required_rubygems_version = Gem::Requirement.new(">= 0".freeze) if s.respond_to? :required_rubygems_version=
  s.require_paths = ["lib".freeze]
  s.authors = ["Craig P Jolicoeur".freeze]
  s.date = "2015-12-02"
  s.description = "Guard::Annotate automatically runs the annotate gem when needed".freeze
  s.email = ["cpjolicoeur@gmail.com".freeze]
  s.homepage = "http://craigjolicoeur.com".freeze
  s.licenses = ["MIT".freeze]
  s.post_install_message = "** guard-annotate is looking for maintainers. While I am still trying\n  to accept and stay on top of new Pull Requests, I no longer personally actively use this guard\n  plugin.  If you are interested in becoming a maintainer please contact me via email at cpjolicoeur@gmail.com. **".freeze
  s.rdoc_options = ["--charset=UTF-8".freeze, "--main=README.md".freeze, "--exclude='(lib|test|spec)|(Gem|Guard|Rake)file'".freeze]
  s.rubyforge_project = "guard-annotate".freeze
  s.rubygems_version = "2.7.6".freeze
  s.summary = "Guard gem for annotate".freeze

  s.installed_by_version = "2.7.6" if s.respond_to? :installed_by_version

  if s.respond_to? :specification_version then
    s.specification_version = 4

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_runtime_dependency(%q<guard-compat>.freeze, [">= 1.2.1", "~> 1.2"])
      s.add_runtime_dependency(%q<annotate>.freeze, [">= 2.4.0", "~> 2.4"])
      s.add_development_dependency(%q<bundler>.freeze, ["~> 1.6"])
    else
      s.add_dependency(%q<guard-compat>.freeze, [">= 1.2.1", "~> 1.2"])
      s.add_dependency(%q<annotate>.freeze, [">= 2.4.0", "~> 2.4"])
      s.add_dependency(%q<bundler>.freeze, ["~> 1.6"])
    end
  else
    s.add_dependency(%q<guard-compat>.freeze, [">= 1.2.1", "~> 1.2"])
    s.add_dependency(%q<annotate>.freeze, [">= 2.4.0", "~> 2.4"])
    s.add_dependency(%q<bundler>.freeze, ["~> 1.6"])
  end
end
