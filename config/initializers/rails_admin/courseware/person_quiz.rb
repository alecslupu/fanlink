RailsAdmin.config do |config|
  config.included_models.push("PersonQuiz")
  config.model "PersonQuiz" do
    parent "PersonQuiz"
  end
end
