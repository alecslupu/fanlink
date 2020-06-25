# frozen_string_literal: true

RailsAdmin.config do |config|
  config.included_models.push('ActsAsTaggableOn::Tag')

  config.model 'ActsAsTaggableOn::Tag' do
    list do
      items_per_page 100
      sort_by :name
    end
  end
end
