# frozen_string_literal: true
RailsAdmin.config do |config|
  config.included_models.push("Badge")
  config.model "Badge" do
    list do
      fields :id,
             :action_type

      field :name do
        searchable false
        queryable false
      end

      fields :internal_name,
             :picture
    end
    edit do
      field :name, :translated
      field :description, :translated
      fields :internal_name,
             :picture,
             :action_type,
             :action_requirement,
             :point_value,
             :issued_from,
             :issued_to
    end
    show do
      fields :id,
             :action_type,
             :name,
             :internal_name,
             :description,
             :action_requirement,
             :point_value,
             :picture,
             :issued_from,
             :issued_to
    end

    export do
      configure :name, :string
      configure :description, :string
    end
  end
end
