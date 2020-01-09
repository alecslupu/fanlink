RailsAdmin.config do |config|
  config.included_models.push("MarketingNotification")

  config.model "MarketingNotification" do
    list do
      fields :id,
             :person,
             :title,
             :body
    end

    show do
      fields :id,
             :person,
             :title,
             :body
    end

    edit do
      fields :title, :body

      field :person_id, :hidden do
        default_value do
          bindings[:view]._current_user.id.to_i
        end
      end
    end
  end
end
