source "https://rubygems.org"

git_source(:github) do |repo_name|
  repo_name = "#{repo_name}/#{repo_name}" unless repo_name.include?("/")
  "https://github.com/#{repo_name}.git"
end

ruby "2.5.1"

# Bundle edge Rails instead: gem "rails", github: "rails/rails"
gem "rails", "~> 5.1.4"
# Use postgresql as the database for Active Record
gem "pg", "~> 0.18"
# Use Puma as the app server
gem "puma", "~> 3.7"
# Use SCSS for stylesheets
gem "sass-rails", "~> 5.0"
# Use Uglifier as compressor for JavaScript assets
gem "uglifier", ">= 1.3.0"
# See https://github.com/rails/execjs#readme for more supported runtimes
# gem "therubyracer", platforms: :ruby

# Use CoffeeScript for .coffee assets and views
gem "coffee-rails", "~> 4.2"
# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
gem "jbuilder", "~> 2.5"
# Use Redis adapter to run Action Cable in production
gem 'redis'
gem 'redis-namespace'
gem 'redis-rails'
# Use ActiveModel has_secure_password
# gem "bcrypt", "~> 3.1.7"

# Use Capistrano for deployment
# gem "capistrano-rails", group: :development
#

group :production, :staging do
  gem 'newrelic_rpm'
end

group :staging, :development do
end

group :development, :test do
  # Call "byebug" anywhere in the code to stop execution and get a debugger console
  gem "byebug", platforms: [:mri, :mingw, :x64_mingw]
  gem "dotenv-rails"
  gem "faker"
  gem "rspec-rails"
  gem "factory_bot_rails"
end

group :development do
  gem "better_errors"
  gem "binding_of_caller"
  gem "daemons"
  gem "gettext", ">=3.0.2", require: false
  # Access an IRB console on exception pages or by using <%= console %> anywhere in the code.
  gem "web-console", ">= 3.3.0"
  gem "listen", ">= 3.0.5", "< 3.2"
  gem "lol_dba"
  gem "seed_dump"
  gem "awesome_print", require:"ap"
  gem "apigen", :path => 'lib/gems/apigen'
  gem 'memory_profiler'
  gem 'derailed_benchmarks'
end

group :test do
  gem "database_cleaner", require: false
  gem "simplecov", require: false
  gem "timecop"
  gem "webmock"
  gem 'wisper-rspec', require: false
end

gem "acts_as_tenant" #, git: "https://github.com/mark100net/acts_as_tenant.git" #they are still using before_filter :/
gem "administrate", "~> 0.10.0" #git: "https://github.com/thoughtbot/administrate.git"

gem "administrate-field-enum", git: "https://markfraser@bitbucket.org/markfraser/administrate-field-enum.git", branch: "collection-member-fix"
gem 'administrate-field-hidden', '~> 0.0.3'

# For the below, I added a PR on the gem: https://github.com/picandocodigo/administrate-field-paperclip/pull/10
# I haven't received a reply/action but if the PR has not been acted upon due to "failing checks", then the only
# 'solution' is to do another PR which fixes the failing checks (such failure having nothing to do with my commit)
gem "administrate-field-paperclip", git: "https://github.com/mark100net/administrate-field-paperclip.git", branch: "blank-attachment-text"
gem "api-pagination"
gem "attribute_normalizer"
gem "aws-sdk"
gem "countries"
gem "delayed_job_active_record"
gem "email_validator"
gem "fcm" #Firebase Cloud Messaging
gem "filterrific"
gem "firebase", git: "https://github.com/oscardelben/firebase-ruby.git"
gem 'flag_shih_tzu'
gem "gettext_i18n_rails"
gem "google_places"
gem "jko_api" # api versioning
gem "kaminari"
gem "koala" #Facebook Graph API
# we can forgo this if they ever merge in
# https://bitbucket.org/mailchimp/mandrill-api-ruby/pull-requests/8/fix-json-version
gem "mandrill-api", bitbucket: "markfraser/mandrill-api-ruby", require: "mandrill"
# I don't necessarily love this thing but then I don't love ActionMailer either
gem "mandrill_mailer", "~> 1.6"
gem "paper_trail"
gem "oauth2"
gem "oj" #json opt recommended with rollbar
gem "paperclip", "~> 5.0.0"
gem 'paperclip-meta'
gem "postgresql-check"
gem "rack-cors", require: "rack/cors"
gem "rack-timeout"
gem "rest-firebase"
gem "rollbar"
gem "rubocop-rails"
gem "sorcery"
gem "unicode_utils"
gem "uuidtools"
gem 'wisper', '2.0.0'
gem 'wisper-activejob'
gem 'wisper-activerecord'
#gem 'chewy'#testTest
gem 'versionist'
gem 'jbuilder_cache_multi'
gem 'zero-rails_openapi', github: 'zhandao/zero-rails_openapi'
