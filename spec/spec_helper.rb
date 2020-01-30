require "pry"
require "simplecov"
# require "coverage_helper"
SimpleCov.start "rails" do
  add_filter "app/channels" # nothing here
  add_filter "app/controllers/admin" # administrate stuff
  add_filter "app/dashboards"
  add_filter "app/fields"
  add_filter "lib/gems/apigen"
  add_filter "app/lib/rails_admin"
  add_filter "lib/generators/fanlink"
  # add_group "jobs", "app/jobs" # nothing here
  add_group "Listeners", "app/listeners" # nothing here
  add_group "Policies", "app/policies" # nothing here

  minimum_coverage 0
  enable_coverage :branch
end
require File.expand_path("../../config/environment", __FILE__)
require 'paper_trail/frameworks/rspec'
require "rspec/rails"
require "webmock/rspec"
require "database_cleaner"
require "mandrill_mailer/offline"
require "json_schemer"
Dir[Rails.root.join("spec/support/**/*.rb")].each { |f| require f }
WebMock.disable_net_connect!(allow_localhost: true)

# This file was generated by the `rails generate rspec:install` command. Conventionally, all
# specs live under a `spec` directory, which RSpec adds to the `$LOAD_PATH`.
# The generated `.rspec` file contains `--require spec_helper` which will cause
# this file to always be loaded, without a need to explicitly require it in any
# files.
#
# Given that it is always loaded, you are encouraged to keep this file as
# light-weight as possible. Requiring heavyweight dependencies from this file
# will add to the boot time of your test suite on EVERY test run, even for an
# individual file that may not need all of that loaded. Instead, consider making
# a separate helper file that requires the additional dependencies and performs
# the additional setup, and require it from the spec files that actually need
# it.
#
# See http://rubydoc.info/gems/rspec-core/RSpec/Core/Configuration
RSpec.configure do |config|
  # rspec-expectations config goes here. You can use an alternate
  # assertion/expectation library such as wrong or the stdlib/minitest
  # assertions if you prefer.
  config.expect_with :rspec do |expectations|
    # This option will default to `true` in RSpec 4. It makes the `description`
    # and `failure_message` of custom matchers include text for helper methods
    # defined using `chain`, e.g.:
    #     be_bigger_than(2).and_smaller_than(4).description
    #     # => "be bigger than 2 and smaller than 4"
    # ...rather than:
    #     # => "be bigger than 2"
    expectations.include_chain_clauses_in_custom_matcher_descriptions = true
  end

  # rspec-mocks config goes here. You can use an alternate test double
  # library (such as bogus or mocha) by changing the `mock_with` option here.
  config.mock_with :rspec do |mocks|
    # Prevents you from mocking or stubbing a method that does not exist on
    # a real object. This is generally recommended, and will default to
    # `true` in RSpec 4.
    mocks.verify_partial_doubles = true
  end

  # This option will default to `:apply_to_host_groups` in RSpec 4 (and will
  # have no way to turn it off -- the option exists only for backwards
  # compatibility in RSpec 3). It causes shared context metadata to be
  # inherited by the metadata hash of host groups and examples, rather than
  # triggering implicit auto-inclusion in groups with matching metadata.
  config.shared_context_metadata_behavior = :apply_to_host_groups

  # The settings below are suggested to provide a good initial experience
  # with RSpec, but feel free to customize to your heart's content.
  #   # This allows you to limit a spec run to individual examples or groups
  #   # you care about by tagging them with `:focus` metadata. When nothing
  #   # is tagged with `:focus`, all examples get run. RSpec also provides
  #   # aliases for `it`, `describe`, and `context` that include `:focus`
  #   # metadata: `fit`, `fdescribe` and `fcontext`, respectively.
  #   config.filter_run_when_matching :focus
  #
  #   # Allows RSpec to persist some state between runs in order to support
  #   # the `--only-failures` and `--next-failure` CLI options. We recommend
  #   # you configure your source control system to ignore this file.
  #   config.example_status_persistence_file_path = "spec/examples.txt"
  #
  #   # Limits the available syntax to the non-monkey patched syntax that is
  #   # recommended. For more details, see:
  #   #   - http://rspec.info/blog/2012/06/rspecs-new-expectation-syntax/
  #   #   - http://www.teaisaweso.me/blog/2013/05/27/rspecs-new-message-expectation-syntax/
  #   #   - http://rspec.info/blog/2014/05/notable-changes-in-rspec-3/#zero-monkey-patching-mode
  #   config.disable_monkey_patching!
  #
  #   # Many RSpec users commonly either run the entire suite or an individual
  #   # file, and it's useful to allow more verbose output when running an
  #   # individual spec file.
  #   if config.files_to_run.one?
  #     # Use the documentation formatter for detailed output,
  #     # unless a formatter has already been configured
  #     # (e.g. via a command-line flag).
  #     config.default_formatter = "doc"
  #   end
  #
  #   # Print the 10 slowest examples and example groups at the
  #   # end of the spec run, to help surface which specs are running
  #   # particularly slow.
  #   config.profile_examples = 10
  # config.seed = 1234

  # Run specs in random order to surface order dependencies. If you find an
  # order dependency and want to debug it, you can fix the order by providing
  # the seed, which is printed after each run.
  #     --seed 1234
  config.order = :random

  # Seed global randomization in this process using the `--seed` CLI option.
  # Setting this allows you to use `--seed` to deterministically reproduce
  # test failures related to randomization by passing the same `--seed` value
  # as the one that triggered the failure.
  Kernel.srand config.seed

  config.before(:suite) do
    Rails.logger.debug("RSPEC: before suite")
    DatabaseCleaner.strategy = :transaction
    DatabaseCleaner.clean_with(:truncation)
  end
  config.after(:each) do
    Rails.logger.debug("RSPEC: after example")
    DatabaseCleaner.clean
    logout
    ActsAsTenant.current_tenant = nil
  end

  config.around(:each) do |example|
    Rails.logger.debug("Running before clean")

    DatabaseCleaner.cleaning do
      Rails.logger.debug("RSPEC: #{example.description}")
      example.run
      Rails.logger.debug("RSPEC END: #{example.description}")
    end
    logout
    ActsAsTenant.current_tenant = nil
  end

  config.include Sorcery::TestHelpers::Rails::Controller, type: :controller
  config.include Sorcery::TestHelpers::Rails::Integration, type: :feature
  config.include Sorcery::TestHelpers::Rails

  config.include RSpec::Rails::RequestExampleGroup, type: :request
  config.include RSpec::Rails::RequestExampleGroup, type: :feature, file_path: /spec\/(step|feature)/

  config.include MandrillMailerHelper
  config.include ProductHelpers
  config.include SessionHelpers
  config.include RequestHelpers
  config.include JsonHelpers, type: :controller

  config.before :each, type: :controller do
    if self.class.name.include?("Api")
      @json = nil
      vmatch = /V([0-9]).*\:\:/.match(self.class.name)
      @api_version = "v#{vmatch[1]}"
    end
  end

  config.fixture_path = "spec/fixtures"

  if Bullet.enable?
    config.before(:each) { Bullet.start_request }
    config.after(:each) { Bullet.end_request }
  end
end
