source "https://rubygems.org"

git_source(:github) do |repo_name|
  repo_name = "#{repo_name}/#{repo_name}" unless repo_name.include?("/")
  "https://github.com/#{repo_name}.git"
end
git_source(:fanlink) do |repo_name|
  repo_name = "#{repo_name}/#{repo_name}" unless repo_name.include?("/")
  "https://gitlab.fan.link/#{repo_name}"
end

ruby "2.5.1"

if ENV["RAILS6"]
  gem "rails", "~> 5.2"
else
  # Bundle edge Rails instead: gem "rails", github: "rails/rails"
  gem "rails", "~> 5.2"
end


# gem "rack-cache"
# Use Puma as the app server
gem 'puma', '~> 3.12'
# Use SCSS for stylesheets
gem 'sass-rails', '~> 5.0'
# Use Uglifier as compressor for JavaScript assets
gem 'uglifier', '>= 1.3.0'
# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
gem 'jbuilder', '~> 2.5'

# Reduces boot times through caching; required in config/boot.rb
gem 'bootsnap', '>= 1.1.0', require: false

# else
#   # See https://github.com/rails/execjs#readme for more supported runtimes
#   gem "therubyracer", platforms: :ruby
#   # Use CoffeeScript for .coffee assets and views
#   gem "coffee-rails", "~> 4.2"
# Use Redis adapter to run Action Cable in production
gem "redis"
# Use ActiveModel has_secure_password
# gem "bcrypt", "~> 3.1.7"

# gem "rails", "~> 5.2.2"
# Use postgresql as the database for Active Record
gem "pg", "~> 0.18"


gem "json", "~> 2.3.0"

gem "jb"
gem "redis-namespace"
gem "redis-rails"

gem "httparty", "0.16.4"

# Use Capistrano for deployment
# gem "capistrano-rails", group: :development
#

group :production, :staging do
  gem 'elastic-apm', '~> 3.1.0'
end

group :staging, :development, :test do
  gem "derailed_benchmarks", "~>1.3.6"
  gem "stackprof"
  gem "bullet", "~>6.0.2"
end

group :development, :test do
  # Call "byebug" anywhere in the code to stop execution and get a debugger console
  gem "pry", "~>0.12.2"
  gem "byebug", "~>11.0.1", platforms: [:mri, :mingw]
  gem "pry-byebug", "~>3.7.0"
  gem "dotenv-rails", "~>2.7.5"
  gem "faker", "~>2.1.2"
  gem "rspec-mocks", "~> 3.9.0"
  gem "rspec-rails", "~> 3.9.0"
  gem "rails-controller-testing"
  gem "factory_bot_rails", "~>5.0.2"
  gem "fuubar", "~>2.4.1"
  gem "httplog"

  gem "rubocop", "~> 0.76.0", require: false
  # gem "rubocop-rails_config"
  gem "rubocop-rails", require: false
  gem "rubocop-rspec", require: false
  gem "rubocop-performance", require: false

  gem "rails-erd"
end

group :development do
  gem "better_errors", "~>2.5.1"
  gem "binding_of_caller"
  gem "gettext", ">=3.0.2", require: false

  # Access an IRB console on exception pages or by using <%= console %> anywhere in the code.
  gem "web-console", ">= 3.3.0"
  gem "listen", ">= 3.0.5", "< 3.2"
  # Spring speeds up development by keeping your application running in the background. Read more: https://github.com/rails/spring
  gem 'spring'
  gem 'spring-watcher-listen', '~> 2.0.0'
  gem "lol_dba"
  gem "seed_dump"
  gem "awesome_print", require: "ap"
  #
  gem "memory_profiler"
  #   gem 'zero-rails_openapi', github: 'zhandao/zero-rails_openapi'
  gem "launchy"
  gem "guard-rspec"
  gem "guard-rubocop"
  gem "guard-brakeman"
  gem "guard-annotate"
  # gem "guard-rubycritic"
  gem "rubycritic"

  gem "capistrano", require: false
  gem "capistrano-bundler", require: false
  gem "capistrano-rails", require: false
  gem "slackistrano", require: false
  gem "capistrano3-puma" , require: false
end

group :test do
  # gem "cucumber-rails", "~>1.8.0", require: false
  gem "database_cleaner", require: false
  gem "simplecov", "~>0.18", require: false
  gem "simplecov-console", require: false
  gem "timecop"
  gem "webmock", "~>3.6.2"
  gem "shoulda-matchers", git: "https://github.com/thoughtbot/shoulda-matchers.git", branch: "rails-5"
  gem "wisper-rspec", require: false
  gem "json_schemer", "~>0.2.5"
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

gem "rails_admin", "1.3.0"
gem "rails_admin_nested_set"

gem "api-pagination"
# gem 'ar-octopus', git: "https://github.com/thiagopradi/octopus", branch: "master"
gem "attribute_normalizer"
gem "aws-sdk"
gem "countries"
gem "daemons", "~>1.3.1"
gem "delayed_job_web"
gem "delayed_job_active_record"
gem "email_validator"
gem "fcm" # Firebase Cloud Messaging
gem "filterrific"
gem "firebase", git: "https://github.com/oscardelben/firebase-ruby.git"
gem "flag_shih_tzu"
gem "gettext_i18n_rails"
gem "goldiloader"
gem "google_places"
gem "has_scope"
gem "kaminari"
gem "koala" # Facebook Graph API
# we can forgo this if they ever merge in
# https://bitbucket.org/mailchimp/mandrill-api-ruby/pull-requests/8/fix-json-version
gem "mandrill-api", fanlink: "dependencies/mandrill-api-ruby", require: "mandrill"
#
gem "excon", ">= 0.71"
# I don't necessarily love this thing but then I don't love ActionMailer either
gem "mandrill_mailer", "~> 1.6"
gem "paper_trail"
gem "oauth2"
gem "oj" # json opt recommended with rollbar
gem "paperclip", "~> 6.1.0"
gem "paperclip-meta"
gem "paperclip-dimension-validator"
gem "pg_search"
gem "postgresql-check"
gem "pundit"
gem "rack-cors", require: "rack/cors"
# gem "rack-timeout"
gem "rest-firebase"
gem "sorcery"
gem "timber", "~> 2.0"
gem "unicode_utils"
gem "uuidtools"
gem "wisper", "> 2.0.0"
gem "wisper-activejob"
gem "wisper-activerecord"

# To get video's length
gem "streamio-ffmpeg"

gem "rmagick"

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
gem "actionpack-page_caching"

gem "aasm"
# for cron jobs
# https://github.com/javan/whenever
gem 'whenever', require: false
