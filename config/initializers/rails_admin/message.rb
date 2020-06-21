# frozen_string_literal: true

RailsAdmin.config do |config|
  config.included_models.push("Message")
  config.model "Message" do
    configure :created_at do
      strftime_format "%m/%d/%Y %H:%M:%S"
    end
    configure :updated_at do
      strftime_format "%m/%d/%Y %H:%M:%S"
    end
    list do
      scopes [nil, :reported, :not_reported]

      fields :created_at,
             :person,
              :room,
              :id,
              :body
      field :reported do
        pretty_value do
          bindings[:object].reported?
        end
      end
    end
    show do
      fields :person, :room, :id, :body, :hidden, :created_at, :updated_at
    end
  end
end
