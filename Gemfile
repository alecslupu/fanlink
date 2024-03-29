source "https://rubygems.org"

git_source(:github) do |repo_name|
  repo_name = "#{repo_name}/#{repo_name}" unless repo_name.include?("/")
  "https://github.com/#{repo_name}.git"
end
git_source(:fanlink) do |repo_name|
  repo_name = "#{repo_name}/#{repo_name}" unless repo_name.include?("/")
  "https://gitlab.fan.link/#{repo_name}"
end

ruby ENV['CUSTOM_RUBY_VERSION'] || "2.5.1"

if ENV["RAILS_EDGE"]
  # gem "rails", github: "rails/rails"
  # gem 'sass-rails', '~> 6.0'
else
  gem "rails", "~> 6.0.3"
  # Use SCSS for stylesheets
  gem 'sass-rails', '~> 6.0'
end

# gem 'sprockets', '>= 4.0.2'
# SegFault Bug ... needs investigationbug https://github.com/rails/sprockets/issues/633
gem 'sprockets', '~> 3.7.2'

# gem "rack-cache"
# Use Puma as the app server
gem 'puma', '>= 4.3.4'

# Use Uglifier as compressor for JavaScript assets
gem "uglifier", ">= 1.3.0"

# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
gem 'jbuilder', '>= 2.10.0'

# Use CoffeeScript for .coffee assets and views
gem "coffee-rails"

# Reduces boot times through caching; required in config/boot.rb
# gem 'bootsnap', '>= 1.1.0', require: false

# Use ActiveModel has_secure_password
gem "bcrypt", "~> 3.1.7"
# Use Redis adapter to run Action Cable in production
gem "redis"

# gem "rails", "~> 5.2.2"
# Use postgresql as the database for Active Record
gem "pg", ">= 1.2.3"


gem "json", "~> 2.3.0"

gem "jb"
gem "redis-namespace"
gem "redis-rails"

gem "httparty", ">= 0.18.1"

# Use Capistrano for deployment
# gem "capistrano-rails", group: :development
#

group :production, :staging do
  gem 'elastic-apm', '>= 3.7.0'
end

group :staging, :development do
  # Access an IRB console on exception pages or by using <%= console %> anywhere in the code.
  gem "web-console", ">= 4.0.2"
  gem "listen", ">= 3.0.5", "< 3.2"
end
group :staging, :development, :test do
  gem "derailed_benchmarks", ">= 1.7.0"
  gem "stackprof"
  gem "bullet", ">= 6.1.0"
end

group :development, :test do
  # Call "byebug" anywhere in the code to stop execution and get a debugger console
  gem "pry", ">= 0.13.0"
  gem "byebug", "~> 11.1.3", platforms: [:mri, :mingw]
  gem "pry-byebug", ">= 3.9.0"
  gem "dotenv-rails", "~>2.7.5"
  gem "faker", ">= 2.12.0"
  gem "rspec-mocks", "~> 3.9.0"
  gem "rspec-rails", "~> 4.0.1"
  gem "rails-controller-testing"
  gem "factory_bot_rails", ">=5.2.0"
  gem "fuubar", ">= 2.5.0"
  gem "httplog"

  gem "rubocop", ">= 0.85.0", require: false
  # gem "rubocop-rails_config"
  gem "rubocop-rails", ">= 2.6.0", require: false
  gem "rubocop-rspec", ">= 1.40.0", require: false
  gem "rubocop-performance", ">= 1.6.1", require: false

  gem "rails-erd"
end

group :development do
  gem "better_errors", ">= 2.7.1"
  gem "binding_of_caller"
  gem "gettext", ">=3.0.2", require: false

  # Spring speeds up development by keeping your application running in the background. Read more: https://github.com/rails/spring
  gem 'spring'
  gem 'spring-watcher-listen', '~> 2.0.0'
  gem "lol_dba"
  # gem "seed_dump"
  gem "awesome_print", require: "ap"
  #
  gem "memory_profiler"
  #   gem 'zero-rails_openapi', github: 'zhandao/zero-rails_openapi'
  gem "launchy"
  gem "guard-rspec"
  # gem "guard-rubocop"
  gem "guard-brakeman", ">= 0.8.6"
  gem "guard-annotate"
  # gem "guard-rubycritic"
  gem "rubycritic", ">= 4.5.0"

  gem "capistrano", "> 3.14", require: false
  gem "capistrano-bundler", require: false
  gem "capistrano-rails", ">= 1.5.0", require: false
  gem "slackistrano", require: false
  gem "capistrano3-puma", ">= 4.0.0", require: false
end

group :test do
  # gem "cucumber-rails", "~>1.8.0", require: false
  gem "database_cleaner", require: false
  gem "simplecov", "~>0.18", require: false
  gem "simplecov-console", require: false
  gem "timecop"
  gem "webmock", ">=3.8.3"
  gem "shoulda-matchers", git: "https://github.com/thoughtbot/shoulda-matchers.git", branch: "rails-5"
  gem "wisper-rspec", require: false
  gem "json_schemer", ">= 0.2.11"
  gem "turnip", require: false
end

# greg is saying that is not suporting V Rails 5.2.
gem "acts_as_tenant" # , git: "https://github.com/mark100net/acts_as_tenant.git" #they are still using before_filter :/
gem "acts_as_api"
#
# gem "administrate", "~> 0.11.0" # git: "https://github.com/thoughtbot/administrate.git"
# gem "administrate-field-enum", git: "https://markfraser@bitbucket.org/markfraser/administrate-field-enum.git", branch: "collection-member-fix"
# gem "administrate-field-hidden", "~> 0.0.3"
# gem "administrate-field-belongs_to_search"
# # For the below, I added a PR on the gem: https://github.com/picandocodigo/administrate-field-paperclip/pull/10
# # I haven't received a reply/action but if the PR has not been acted upon due to "failing checks", then the only
# # 'solution' is to do another PR which fixes the failing checks (such failure having nothing to do with my commit)
# gem "administrate-field-paperclip", git: "https://github.com/mark100net/administrate-field-paperclip.git", branch: "blank-attachment-text"

gem "awesome_nested_set"

gem "rails_admin", "~> 2.0.0"
gem "rails_admin_nested_set"

gem "api-pagination"
# gem 'ar-octopus', git: "https://github.com/thiagopradi/octopus", branch: "master"
gem "attribute_normalizer"

gem 'aws-sdk-s3', '>= 1.68.0'
gem 'aws-sdk-sns', '>= 1.25.1'
gem 'aws-sdk-sqs', '>= 1.27.1'
gem 'aws-sdk-elastictranscoder', '>= 1.22.1'

gem "countries"
gem "daemons", "~>1.3.1"
gem 'sidekiq', ">= 6.0.7"
gem "email_validator"
gem "fcm" # Firebase Cloud Messaging
# gem "filterrific"
gem "firebase", git: "https://github.com/oscardelben/firebase-ruby.git"
gem "flag_shih_tzu"
gem "gettext_i18n_rails"
gem "goldiloader"
gem "google_places"
gem "has_scope"
gem "kaminari", ">= 1.2.1"
gem "koala" # Facebook Graph API
# we can forgo this if they ever merge in
# https://bitbucket.org/mailchimp/mandrill-api-ruby/pull-requests/8/fix-json-version
# gem "mandrill-api", fanlink: "dependencies/mandrill-api-ruby", require: "mandrill"
#
# gem "excon", ">= 0.71"
# I don't necessarily love this thing but then I don't love ActionMailer either
# gem "mandrill_mailer", "~> 1.6"
gem "paper_trail"
gem "oauth2"
gem "oj" # json opt recommended with rollbar
gem "paperclip", "~> 6.1.0"
gem "paperclip-meta"
gem "paperclip-dimension-validator"
# gem "pg_search"
gem "postgresql-check", ">= 0.1.4"
gem "pundit"
gem "rack-cors", require: "rack/cors"
# gem "rack-timeout"
gem "rest-firebase"
gem "sorcery", ">= 0.15.0"
gem "unicode_utils"
gem "uuidtools"
gem "wisper", "> 2.0.0"
gem "wisper-activejob"
# remove the git stuff https://github.com/krisleech/wisper-activerecord/pull/30 is approved
gem "wisper-activerecord", github: 'alecslupu/wisper-activerecord'

# To get video's length
gem "streamio-ffmpeg"

gem 'active_storage_validations'
gem "image_processing"

gem "mini_magick"
# gem "rmagick"

# Use Json Web Token (JWT) for token based authentication
gem "jwt"
gem "prawn"

gem "erubis"

group :development, :test do
  gem "rswag-specs"
end

group :test do
  gem "pundit-matchers", "~> 1.6.0"
end

# Gemfile
gem "rswag-api"
gem "rswag-ui"

gem "psych"
#for page caching
gem "actionpack-page_caching", ">= 1.2.3"

gem "aasm"
# for cron jobs
# https://github.com/javan/whenever
gem 'whenever', require: false

gem 'acts-as-taggable-on'

gem 'globalize'
gem 'globalize-versioning'
gem 'rails_admin_globalize_field'
