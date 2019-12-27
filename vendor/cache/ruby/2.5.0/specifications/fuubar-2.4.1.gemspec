# -*- encoding: utf-8 -*-
# stub: fuubar 2.4.1 ruby lib

Gem::Specification.new do |s|
  s.name = "fuubar".freeze
  s.version = "2.4.1"

  s.required_rubygems_version = Gem::Requirement.new(">= 0".freeze) if s.respond_to? :required_rubygems_version=
  s.metadata = { "bug_tracker_uri" => "https://github.com/thekompanee/fuubar/issues", "changelog_uri" => "https://github.com/thekompanee/fuubar/blob/master/CHANGELOG.md", "documentation_uri" => "https://github.com/thekompanee/fuubar/tree/releases/v2.4.0", "homepage_uri" => "https://github.com/thekompanee/fuubar", "source_code_uri" => "https://github.com/thekompanee/fuubar", "wiki_uri" => "https://github.com/thekompanee/fuubar/wiki" } if s.respond_to? :metadata=
  s.require_paths = ["lib".freeze]
  s.authors = ["Nicholas Evans".freeze, "Jeff Kreeftmeijer".freeze, "jfelchner".freeze]
  s.cert_chain = ["-----BEGIN CERTIFICATE-----\nMIIEdjCCAt6gAwIBAgIBATANBgkqhkiG9w0BAQsFADAyMTAwLgYDVQQDDCdhY2Nv\ndW50c19ydWJ5Z2Vtcy9EQz10aGVrb21wYW5lZS9EQz1jb20wHhcNMTgwODAzMjEz\nNjUzWhcNMTkwODAzMjEzNjUzWjAyMTAwLgYDVQQDDCdhY2NvdW50c19ydWJ5Z2Vt\ncy9EQz10aGVrb21wYW5lZS9EQz1jb20wggGiMA0GCSqGSIb3DQEBAQUAA4IBjwAw\nggGKAoIBgQDR6ma5Z4B2Qz+ykVUKn2CoWwoJ3vStZLDNc6nIOUTUDFS5rg43XwwB\nnnHCLhHZ9QeNflBpJObMwIUwDqxfZoxhmEILzUfv/yuoBj90zmnf7K2mmsPuT44a\naTyZjYGid+yyTbzIpR4CCBHyvGNVm9ss64C2XXPNXrlLO3eAxgB9zNYkxOeJatZp\nd1h5FZIkAqgw7rx65W+e4HUSNnUvzUmZKoO0u/yMlnc4NcK05RdgHZ5FcXgSAZG/\nMRzJ0rIdEk7wT8fBJ6w9oeFca8qW7C9M/ONJ4WiS+HoquCRcR+FiNAS3LQtQbiaR\nADVS0CBzc2/6zBxWf/+C6wv8vEkoIDSgJ4T07IV2oEJH2ox1z0PYLcNQ9KIrz9iW\n+Q2DPjjO2+ymR3QOBpOrDr4keYS25tfUiSkBXemHj94Bm95/Szi8At8ywCtBVWUx\nAumxK9WPjr7WFDk5o71NX4SZft99Ey5XBeZ1+I2v4+ozio/cqOFz9UTarQryCf0e\n2uJLFPBPkzcCAwEAAaOBljCBkzAJBgNVHRMEAjAAMAsGA1UdDwQEAwIEsDAdBgNV\nHQ4EFgQUUTthhLkcr6+8JU1/B/dxKYaYnKUwLAYDVR0RBCUwI4EhYWNjb3VudHMr\ncnVieWdlbXNAdGhla29tcGFuZWUuY29tMCwGA1UdEgQlMCOBIWFjY291bnRzK3J1\nYnlnZW1zQHRoZWtvbXBhbmVlLmNvbTANBgkqhkiG9w0BAQsFAAOCAYEAED2U/MD3\nPHRHyeh9Ge3JTKJ/bjZLYquJWQr+ei4rsNk8oO2O6CcoiC84oNEnpnENHX9KiZu8\nh7ylKO7u6vKJl9p9IV2YR0uOnXbSApYr5olDDlEz7HNGL3xUCJJhJBf09C4AkaAn\nkfaOv9Nkko0izYPpKsGlyKvbWBIzT3urBMRNbv95DzhBdNI6RF0q13eCePPqXPGe\nRaikE1dUWcVsW29XzO/RINmuMcKU6k0caC7X4kTD657Nf74oGUXHxYPmfUmYmppg\nuAF3jK5824uMvxofLysxqXhrUlTuCVndaexDm3bYK+YrTnZJEu6CimpMYa2u6JEE\nsWLZKmDLUxEUs/5jVGuypZbSBJBDb6VnmCkoEr3Fmh4O/FH4IZ+Gd3QdYCohLoKd\n09JNgxpgZHCDuKwoycU+wXdWVSzMtchMQygnEu6th1SY5qHj4ISipBEBtKG0MdgB\nL3AbMAHTztj5YI+gvmpuV1B4Zv1QZjZWOeNSnLZdrnOQbyyDBzJyXmNV\n-----END CERTIFICATE-----\n".freeze]
  s.date = "2019-07-03"
  s.description = "the instafailing RSpec progress bar formatter".freeze
  s.email = ["jeff@kreeftmeijer.nl".freeze, "accounts+git@thekompanee.com".freeze]
  s.homepage = "https://github.com/thekompanee/fuubar".freeze
  s.licenses = ["MIT".freeze]
  s.rubygems_version = "2.7.6".freeze
  s.summary = "the instafailing RSpec progress bar formatter".freeze

  s.installed_by_version = "2.7.6" if s.respond_to? :installed_by_version

  if s.respond_to? :specification_version then
    s.specification_version = 4

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_runtime_dependency(%q<rspec-core>.freeze, ["~> 3.0"])
      s.add_runtime_dependency(%q<ruby-progressbar>.freeze, ["~> 1.4"])
      s.add_development_dependency(%q<rspec>.freeze, ["~> 3.7"])
    else
      s.add_dependency(%q<rspec-core>.freeze, ["~> 3.0"])
      s.add_dependency(%q<ruby-progressbar>.freeze, ["~> 1.4"])
      s.add_dependency(%q<rspec>.freeze, ["~> 3.7"])
    end
  else
    s.add_dependency(%q<rspec-core>.freeze, ["~> 3.0"])
    s.add_dependency(%q<ruby-progressbar>.freeze, ["~> 1.4"])
    s.add_dependency(%q<rspec>.freeze, ["~> 3.7"])
  end
end
