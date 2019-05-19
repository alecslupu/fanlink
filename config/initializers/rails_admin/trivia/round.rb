RailsAdmin.config do |config|

  config.included_models << "Trivia::Round"
  config.model "Trivia::Round" do
    parent "Trivia::Game"

    edit do
      fields :status, :complexity
      field :start_date, :unix_timestamp
      field :questions
    end
    nested do
      exclude_fields :game
      field :questions do
        visible { bindings[:object].persisted? }
      end
    end
  end
end
