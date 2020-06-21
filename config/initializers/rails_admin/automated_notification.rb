# frozen_string_literal: true

RailsAdmin.config do |config|
  config.included_models.push("AutomatedNotification")

  config.model "AutomatedNotification" do

    list do
      field :id do
        column_width 40
      end

      field :person do
        column_width 90
      end

      field :title do
        column_width 130
      end

      field :body do
        column_width 160
      end

      field :criteria do
        column_width 100
      end

      field :last_sent_at do
        column_width 170
      end
      field :enabled do
        column_width 30
      end
      field :ttl_hours
    end

    show do
      fields :id,
             :person,
             :title,
             :body,
             :criteria,
             :last_sent_at,
             :enabled,
             :ttl_hours
    end

    edit do
      fields :id,
             :title,
             :body,
             :criteria,
             :enabled,
             :ttl_hours
    end
  end
end
