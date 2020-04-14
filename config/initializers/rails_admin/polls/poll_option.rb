RailsAdmin.config do |config|
  config.included_models.push("PollOption")

  config.included_models.push("PollOption::Translation")

  config.model 'PollOption::Translation' do
    visible false
    configure :locale, :hidden do
      help ''
    end
    include_fields :locale, :description
    #
    # edit do
    #   field :locale, :body
    # end
    export do
      fields :locale, :description
    end
  end

  config.model "PollOption" do
    configure :translations, :globalize_tabs

    parent "Poll"

    edit do
      fields :poll,
             :translations
    end

    nested do
      exclude_fields :person_poll_options, :poll, :people
    end
  end
end
