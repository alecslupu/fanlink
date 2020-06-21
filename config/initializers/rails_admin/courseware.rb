# frozen_string_literal: true

Dir[Rails.root.join("config/initializers/rails_admin/courseware/*.rb")].each { |f| require f }
