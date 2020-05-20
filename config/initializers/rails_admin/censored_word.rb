# frozen_string_literal: true
RailsAdmin.config do |config|
  config.included_models.push("CensoredWord")
  config.model "CensoredWord" do
  end
end
