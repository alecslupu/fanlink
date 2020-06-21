# frozen_string_literal: true

require "simplecov"

SimpleCov.configure do
  add_filter "app/channels" # nothing here
  add_filter "app/controllers/admin" # administrate stuff
  add_filter "app/dashboards"
  add_filter "app/fields"
  add_filter "lib/gems/apigen"
  add_filter "app/lib/rails_admin"
  add_filter "lib/generators/fanlink"
  add_group "Controllers", "app/controllers" # nothing here
  add_group "Channels", "app/channels" # nothing here
  add_group "Helpers", "app/helpers" # nothing here
  add_group "Jobs", "app/jobs" # nothing here
  add_group "Libraries", "app/lib" # nothing here
  add_group "Listeners", "app/listeners" # nothing here
  add_group "Mailers", "app/mailers" # nothing here
  add_group "Models", "app/models" # nothing here
  add_group "Policies", "app/policies" # nothing here

  minimum_coverage 0
  enable_coverage :branch
  coverage_dir ENV.fetch( "COVERAGE_DIR" , 'coverage')
end
