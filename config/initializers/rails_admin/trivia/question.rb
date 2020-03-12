RailsAdmin.config do |config|
  config.included_models.push("Trivia::Question")
  config.model "Trivia::Question" do
    parent "Trivia::Game"
    label_plural "Questions"
    edit do
      fields :round, :time_limit, :question_order, :cooldown_period, :available_question
      #  trivia_round_id :bigint(8)
      #  type            :string
      #  start_date      :integer
      #  end_date        :integer
      #
      #

      field :available_answers do
        read_only { true }
      end
    end
    nested do
      exclude_fields :round
      field :available_answers do
        read_only { true }
      end
    end
  end
end
