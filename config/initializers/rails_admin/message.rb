RailsAdmin.config do |config|
  config.included_models.push("Message")
  config.model "Message" do
    configure :created do
    end
    configure :updated do
    end
    list do
      fields :created,
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
      field :created
      field :body
      field :poster
      field :reporter
      field :reason
      field :status
    end
  end
end
