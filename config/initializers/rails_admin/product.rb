RailsAdmin.config do |config|
  config.included_models.push("Product")
  config.model Product do
    configure :people_count do
    end
    list do
      fields :id,
             :name,
             :internal_name,
             :can_have_supers,
             :people_count
    end
    edit do
      fields :name,
             :internal_name,
             :enabled,
             :can_have_supers,
             :age_requirement
    end
    show do
      fields :id,
             :name,
             :internal_name,
             :enabled,
             :can_have_supers,
             :age_requirement
    end
  end
end
