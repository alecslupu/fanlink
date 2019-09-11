RailsAdmin.config do |config|
  config.included_models.push("StaticContent")

  config.model "StaticContent" do

    list do
      fields :id,
             :title,
             :content
    end

    edit do
      field :title, :translated
      field :content, :translated
    end

    show do
      fields :id,
             :title,
             :content
    end
  end
end
