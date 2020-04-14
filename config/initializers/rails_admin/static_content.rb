RailsAdmin.config do |config|
  config.included_models.push("StaticContent")
  config.included_models.push("WebsiteStaticContent")
  config.included_models.push("EmailStaticContent")

  config.model "StaticContent" do
    list do
      fields :id,
             :title,
             :content,
             :slug
    end

    edit do
      field :title, :translated
      field :content, :translated do
        html_attributes rows: 20, cols: 50
      end
    end

    show do
      fields :id,
             :title,
             :content,
             :slug
    end

    export do
      configure :title, :string
      configure :content, :string
    end
  end
  config.model "WebsiteStaticContent" do
    parent "StaticContent"

    list do
      fields :id,
             :title,
             :content,
             :slug
    end

    edit do
      field :title, :translated
      field :content, :translated do
        html_attributes rows: 20, cols: 50
      end
    end

    show do
      fields :id,
             :title,
             :content,
             :slug
    end

    export do
      configure :title, :string
      configure :content, :string
    end
  end
  config.model "EmailStaticContent" do
    parent "StaticContent"

    list do
      fields :id,
             :title,
             :content,
             :slug
    end

    edit do
      field :title, :translated
      field :content, :translated do
        html_attributes rows: 20, cols: 50
      end
    end

    show do
      fields :id,
             :title,
             :content,
             :slug
    end

    export do
      configure :title, :string
      configure :content, :string
    end
  end
end
