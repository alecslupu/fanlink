require 'simplecov'
require 'simplecov-console'
SimpleCov.formatter = SimpleCov::Formatter::HTMLFormatter

SimpleCov.start "rails" do
  add_filter "app/channels" # nothing here
  add_filter "app/controllers/admin" # administrate stuff
  add_filter "app/dashboards"
  add_filter "app/fields"
  add_filter "lib/gems/apigen"
  add_filter "app/lib/rails_admin"
  # add_group "jobs", "app/jobs" # nothing here
  add_group "listeners", "app/listeners" # nothing here
  add_group "policies", "app/policies" # nothing here

  minimum_coverage 10
end

SimpleCov.at_exit do
  result = SimpleCov.result
  result.format!
end
