RailsAdmin.config do |config|
  config.included_models.push("Trivia::Game")

  config.model "Trivia::Game" do
  #   navigation_label "Trivia"
    label_plural "Trivia Games"
  end

end
