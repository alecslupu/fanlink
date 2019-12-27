# -*- encoding: utf-8 -*-
# stub: batch_api 0.3.0 ruby lib

Gem::Specification.new do |s|
  s.name = "batch_api".freeze
  s.version = "0.3.0"

  s.required_rubygems_version = Gem::Requirement.new(">= 0".freeze) if s.respond_to? :required_rubygems_version=
  s.require_paths = ["lib".freeze]
  s.authors = ["Alex Koppel".freeze]
  s.date = "2015-04-06"
  s.description = "A Batch API plugin that provides a RESTful syntax, allowing clients to make any number of REST calls with a single HTTP request.".freeze
  s.email = ["alex@alexkoppel.com".freeze]
  s.homepage = "http://github.com/arsduo/batch_api".freeze
  s.rubygems_version = "2.7.6".freeze
  s.summary = "A RESTful Batch API for Rails".freeze

  s.installed_by_version = "2.7.6" if s.respond_to? :installed_by_version

  if s.respond_to? :specification_version then
    s.specification_version = 4

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_runtime_dependency(%q<middleware>.freeze, [">= 0"])
    else
      s.add_dependency(%q<middleware>.freeze, [">= 0"])
    end
  else
    s.add_dependency(%q<middleware>.freeze, [">= 0"])
  end
end
