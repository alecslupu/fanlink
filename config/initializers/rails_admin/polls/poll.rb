RailsAdmin.config do |config|
  config.included_models.push("Poll")

  config.model "Poll" do
    parent "Post"

    show do
      fields :id,
             :poll_type,
             :poll_type_id,
             :start_date,
             :end_date,
             :poll_status,
             :duration
      field :description, :translated
    end

    edit do
      fields :id,
             :poll_type
      field :poll_type_id, :integer do
        label "Post id"
      end
      fields :start_date,
             :end_date,
              # :duration,
             :poll_status
      field :description, :translated
      field :poll_options
    end

    list do
      scopes [ nil, :inactive, :active, :disabled ]

      fields :id, :poll_type, :poll_type_id, :start_date, :end_date, :duration, :poll_status
    end
  end
end
