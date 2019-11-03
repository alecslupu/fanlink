RailsAdmin.config do |config|
  config.included_models.push("Trivia::PictureAvailableAnswer")
  config.model "Trivia::PictureAvailableAnswer" do
    parent "Trivia::AvailableAnswer"
    label_plural "Picture Answers"
    nested do
      exclude_fields :question
    end
  end
end
