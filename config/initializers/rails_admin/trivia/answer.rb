RailsAdmin.config do |config|
  config.included_models.push("Trivia::Answer")
  config.model "Trivia::Answer" do
    parent "Trivia::Game"
    navigation_label "Answer"
  end
end