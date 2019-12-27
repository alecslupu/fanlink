# -*- encoding: utf-8 -*-
# stub: hana 1.3.5 ruby lib

Gem::Specification.new do |s|
  s.name = "hana".freeze
  s.version = "1.3.5"

  s.required_rubygems_version = Gem::Requirement.new(">= 0".freeze) if s.respond_to? :required_rubygems_version=
  s.require_paths = ["lib".freeze]
  s.authors = ["Aaron Patterson".freeze]
  s.date = "2019-01-30"
  s.description = "Implementation of [JSON Patch][1] and [JSON Pointer][2] RFC.".freeze
  s.email = ["aaron@tenderlovemaking.com".freeze]
  s.extra_rdoc_files = ["Manifest.txt".freeze, "README.md".freeze]
  s.files = ["Manifest.txt".freeze, "README.md".freeze]
  s.homepage = "http://github.com/tenderlove/hana".freeze
  s.licenses = ["MIT".freeze]
  s.rdoc_options = ["--main".freeze, "README.md".freeze]
  s.rubygems_version = "2.7.6".freeze
  s.summary = "Implementation of [JSON Patch][1] and [JSON Pointer][2] RFC.".freeze

  s.installed_by_version = "2.7.6" if s.respond_to? :installed_by_version

  if s.respond_to? :specification_version then
    s.specification_version = 4

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_development_dependency(%q<minitest>.freeze, ["~> 5.11"])
      s.add_development_dependency(%q<rdoc>.freeze, ["< 7", ">= 4.0"])
      s.add_development_dependency(%q<hoe>.freeze, ["~> 3.17"])
    else
      s.add_dependency(%q<minitest>.freeze, ["~> 5.11"])
      s.add_dependency(%q<rdoc>.freeze, ["< 7", ">= 4.0"])
      s.add_dependency(%q<hoe>.freeze, ["~> 3.17"])
    end
  else
    s.add_dependency(%q<minitest>.freeze, ["~> 5.11"])
    s.add_dependency(%q<rdoc>.freeze, ["< 7", ">= 4.0"])
    s.add_dependency(%q<hoe>.freeze, ["~> 3.17"])
  end
end
