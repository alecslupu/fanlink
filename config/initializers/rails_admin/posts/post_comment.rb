# frozen_string_literal: true

RailsAdmin.config do |config|
  config.included_models.push('PostComment')

  config.model 'PostComment' do
    parent 'Post'
    list do
      scopes [nil, :reported, :not_reported]
    end
  end
end
