RailsAdmin.config do |config|
  config.included_models.push("Trivia::Topic")
  config.model "Trivia::Topic" do
    parent "Trivia::Game"
    label_plural "Topics"
  end
end
