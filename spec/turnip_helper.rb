# frozen_string_literal: true

require "rails_helper"
Dir.glob("spec/steps/**/*steps.rb") { |f| load f, true }

# config.before(:type => :feature) do
#   do_something
# end
