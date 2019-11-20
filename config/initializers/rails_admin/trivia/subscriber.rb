RailsAdmin.config do |config|
  config.included_models.push("Trivia::Subscriber")
  config.model "Trivia::Subscriber" do
    parent "Trivia::Game"
    label_plural "Subscribers"
  end
end
