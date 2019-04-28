RailsAdmin.config do |config|
  config.included_models.push("Room")
  config.model Room do
    list do
      scopes [:publics, nil, :privates]
    end
  end
end
