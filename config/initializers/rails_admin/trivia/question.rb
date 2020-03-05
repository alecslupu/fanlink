RailsAdmin.config do |config|
  config.included_models.push("Trivia::Question")
  config.model "Trivia::Question" do
    parent "Trivia::Game"
    label_plural "Questions"
    edit do
      fields :round, :type, :time_limit, :question_order, :cooldown_period, :available_question
      #  trivia_round_id :bigint(8)
      #  type            :string
      #  start_date      :integer
      #  end_date        :integer
      #
      #
      field :type, :enum do
        enum do
          # Trivia::Question.descendants.map(&:name)
          [
            ["Single Choice", "Trivia::SingleChoiceQuestion"],
            ["Multiple Choice", "Trivia::MultipleChoiceQuestion"],
            ["Picture Choice", "Trivia::PictureQuestion"],
            ["True or False", "Trivia::BooleanChoiceQuestion"],
            ["Fill in the blanks", "Trivia::HangmanQuestion"],
          ]
        end
        read_only { bindings[:object].persisted? }
      end

      field :available_answers do
        read_only { true }
      end
    end
    nested do
      exclude_fields :round
      field :available_answers do
        read_only { true }
      end
      field :type, :enum do
        read_only { bindings[:object].persisted? }
      end

    end
  end
end
