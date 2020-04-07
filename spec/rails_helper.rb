# This file is copied to spec/ when you run "rails generate rspec:install"
ENV["RAILS_ENV"] ||= "test"
require "spec_helper"
require File.expand_path("../../config/environment", __FILE__)
# Prevent database truncation if the environment is production
abort("The Rails environment is running in production mode!") if Rails.env.production?
require "rspec/rails"
require "turnip/rspec"
require "factory_bot_rails"
# Add additional requires below this line. Rails is not loaded until this point!
require "shoulda/matchers"
require "wisper/rspec/matchers"
require "wisper/rspec/stub_wisper_publisher"
require "pundit/rspec"
require "pundit/matchers"
# Requires supporting ruby files with custom matchers and macros, etc, in
# spec/support/ and its subdirectories. Files matching `spec/**/*_spec.rb` are
# run as spec files by default. This means that files in spec/support that end
# in _spec.rb will both be required and run as specs, causing the specs to be
# run twice. It is recommended that you do not name files matching this glob to
# end with _spec.rb. You can configure this pattern with the --pattern
# option on the command line or in ~/.rspec, .rspec or `.rspec-local`.
#
# The following line is provided for convenience purposes. It has the downside
# of increasing the boot-up time by auto-requiring all files in the support
# directory. Alternatively, in the individual `*_spec.rb` files, manually
# require only the support files necessary.
#
Dir[Rails.root.join("spec/support/**/*.rb")].each { |f| require f }

# Checks for pending migrations and applies them before tests are run.
# If you are not using ActiveRecord, you can remove this line.
ActiveRecord::Migration.maintain_test_schema!

ActiveJob::Base.queue_adapter = :test

RSpec.configure do |config|
  config.silence_filter_announcements = true if ENV['TEST_ENV_NUMBER']
  config.render_views
  config.infer_spec_type_from_file_location!

  # Remove this line if you're not using ActiveRecord or ActiveRecord fixtures
  # config.fixture_path = "#{::Rails.root}/spec/fixtures"

  # If you're not using ActiveRecord, or you'd prefer not to run each of your
  # examples within a transaction, remove the following line or assign false
  # instead of true.
  config.use_transactional_fixtures = false

  # from https://stackoverflow.com/questions/19209865/rspec-leaves-record-in-test-database
  # config.around(:each) do |example|
  #   ActiveRecord::Base.transaction do
  #     example.run
  #     raise ActiveRecord::Rollback
  #   end
  # end

  # RSpec Rails can automatically mix in different behaviours to your tests
  # based on their file location, for example enabling you to call `get` and
  # `post` in specs under `spec/controllers`.
  #
  # You can disable this behaviour by removing the line below, and instead
  # explicitly tag your specs with their type, e.g.:
  #
  #     RSpec.describe UsersController, :type => :controller do
  #       # ...
  #     end
  #
  # The different available types are documented in the features, such as in
  # https://relishapp.com/rspec/rspec-rails/docs
  config.infer_spec_type_from_file_location!

  # Filter lines from Rails gems in backtraces.
  config.filter_rails_from_backtrace!
  config.backtrace_inclusion_patterns = [%r{app|spec}]
  # arbitrary gems may also be filtered via:
  # config.filter_gems_from_backtrace("gem name")
  config.include(Wisper::RSpec::BroadcastMatcher)
end

Pundit::Matchers.configure do |config|
  config.user_alias = :person
end

Shoulda::Matchers.configure do |config|
  config.integrate do |with|
    with.test_framework :rspec

    with.library :active_record
    with.library :active_model
    with.library :action_controller
    with.library :rails
  end
end
