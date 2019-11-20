RailsAdmin.config do |config|
  config.included_models.push("Trivia::Prize")
  config.model "Trivia::Prize" do
    parent "Trivia::Game"
    label_plural "Prizes"

    nested do
      exclude_fields :game
    end
  end
end
