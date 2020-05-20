# frozen_string_literal: true
RailsAdmin.config do |config|
  config.included_models.push("Poll")

  config.model "Poll" do


    list do
      fields :id,
             :poll_type
    end

    edit do
      fields :poll_type,
             :poll_type_id,
             :description,
             :start_date,
             :duration,
             :end_date,
             :poll_status,
             :product_id
      field :description, :translated
    end

    export do
      configure :description, :string
    end
  end
end
