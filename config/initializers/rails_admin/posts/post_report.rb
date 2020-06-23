# frozen_string_literal: true

RailsAdmin.config do |config|
  config.included_models.push('PostReport')
  config.model 'PostReport' do
    parent 'Post'

    configure :post_body do
    end
    list do
      scopes [:pending, nil, :post_hidden, :no_action_needed]

      fields :post,
             :person,
             :status,
             :post_body
    end
    show do
      fields :id,
             :post,
             :person,
             :reason,
             :status,
             :updated_at
    end
  end
end
