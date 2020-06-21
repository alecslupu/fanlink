# frozen_string_literal: true

RailsAdmin.config do |config|
  config.included_models.push("MessageReport")
  config.model "MessageReport" do
    parent "Message"

    configure :poster do
    end
    configure :reporter do
    end
    configure :created do
    end

    list do
      scopes [:pending, nil, :message_hidden, :no_action_needed]
      fields :created,
             :message,
             :poster,
             :reporter,
             :reason,
             :status
    end

    show do
      fields :id, :message, :poster, :reporter, :reason, :status
    end
  end
end
