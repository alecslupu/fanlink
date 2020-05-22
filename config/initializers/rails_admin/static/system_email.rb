RailsAdmin.config do |config|
  config.included_models.push("Static::SystemEmail")
  config.included_models.push("Static::SystemEmail::Translation")

  config.model 'Static::SystemEmail::Translation' do
    visible false
    configure :locale, :hidden do
      help ''
    end
    include_fields :locale, :html_template, :text_template, :subject
    #
    # edit do
    #   field :locale, :body
    # end
    export do
      fields :locale, :html_template, :text_template, :subject
    end
  end

  config.model "Static::SystemEmail" do
    configure :translations, :globalize_tabs
    list do
      fields :id,
             :name,
             :slug,
             :public
    end

    edit do
      fields :id, :name, :public, :from_name, :from_email, :translations

      field :images , :multiple_active_storage do
        delete_method :remove_images
      end

      field :attachments, :multiple_active_storage do
        delete_method :remove_attachments
      end
    end

    show do
      fields :id,
             :name,
             :slug
    end

    export do
    end
  end
end
