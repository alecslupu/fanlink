# frozen_string_literal: true

RailsAdmin.config do |config|
  config.included_models.push('Trivia::Subscriber')
  config.model 'Trivia::Subscriber' do
    parent 'Trivia::Game'
    label_plural 'Subscribers'


    edit do
      exclude_fields :product
    end
    nested do
      exclude_fields :product
    end
  end
end
