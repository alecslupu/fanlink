RailsAdmin.config do |config|
  config.included_models.push("Trivia::AvailableAnswer")
  config.model "Trivia::AvailableAnswer" do
    parent "Trivia::Game"

    label_plural "Available Answer"

    edit do
      exclude_fields :product
    end

    nested do
      exclude_fields :question
    end
  end
end
