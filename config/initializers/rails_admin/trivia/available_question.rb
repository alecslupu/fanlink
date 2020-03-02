RailsAdmin.config do |config|
  config.included_models.push("Trivia::AvailableQuestion")
  config.model "Trivia::AvailableQuestion" do
    parent "Trivia::Game"

    label_plural "Available questions"
    edit do
      fields :title, :cooldown_period, :time_limit, :topic, :complexity, :status
      field :type, :enum do
        enum do
          [
            ["Single Choice", "Trivia::SingleChoiceAvailableQuestion"],
            ["Multiple Choice", "Trivia::MultipleChoiceAvailableQuestion"],
            ["Picture Choice", "Trivia::PictureAvailableQuestion"],
            ["True or False", "Trivia::BooleanChoiceAvailableQuestion"],
            ["Fill in the blanks", "Trivia::HangmanAvailableQuestion"],
          ]
        end
        read_only { bindings[:object].persisted? }
      end
      field :available_answers
    end
    nested do
      field :type, :enum do
        read_only { bindings[:object].persisted? }
      end
    end
  end
end
