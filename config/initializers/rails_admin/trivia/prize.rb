RailsAdmin.config do |config|

  config.included_models << "Trivia::Prize"
  config.model "Trivia::Prize" do
    parent "Trivia::Game"

    nested do
      exclude_fields :game
    end
  end
end
