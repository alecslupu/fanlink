RailsAdmin.config do |config|

  config.included_models << "Trivia::Question"
  config.model "Trivia::Question" do
    parent "Trivia::Game"

    edit do
      fields :title, :time_limit, :status, :question_order, :cooldown_period
      #  trivia_round_id :bigint(8)
      #  type            :string
      #  start_date      :integer
      #  end_date        :integer

      field :available_answers
    end
    nested do
      exclude_fields :round
      field :available_answers do
        visible { bindings[:object].persisted? }
      end
    end
  end
end
