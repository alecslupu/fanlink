if ENV['COVERAGE'] == 'true'
  require 'simplecov'
  require 'simplecov-console'
  SimpleCov.formatter = SimpleCov::Formatter::Console

  SimpleCov.start "rails" do
    add_filter "app/channels" # nothing here
    add_filter "app/controllers/admin" # administrate stuff
    add_filter "app/dashboards"
    add_filter "app/fields"
    add_filter "lib/gems/apigen"
    add_filter "app/lib/rails_admin"
    add_filter "lib/generators/fanlink"
    # add_group "jobs", "app/jobs" # nothing here
    add_group "listeners", "app/listeners" # nothing here
    add_group "policies", "app/policies" # nothing here
  end

  if ENV['TEST_ENV_NUMBER'] # parallel specs
    SimpleCov.at_exit do
      result = SimpleCov.result
      result.format! if ParallelTests.number_of_running_processes <= 1
    end
  end
end
