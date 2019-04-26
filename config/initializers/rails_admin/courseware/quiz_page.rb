RailsAdmin.config do |config|
  config.included_models.push("QuizPage")
  config.model "QuizPage" do
    parent "Certificate"
  end
end
