# frozen_string_literal: true
RailsAdmin.config do |config|
  config.included_models.push("Trivia::PictureAvailableAnswer")
  config.model "Trivia::PictureAvailableAnswer" do
    parent "Trivia::AvailableAnswer"
    label_plural "Picture Answers"

    edit do
      exclude_fields :product
    end

    nested do
      exclude_fields :question
    end
  end
end
