module Trivia
  class GameGenerator
    def initialize
    end

    def generate
      @game = Trivia::Game.create!(
        status: :draft,
        leaderboard_size: 10,
        long_name: "Generated Game #{DateTime.now.to_i}",
        short_name: "Generated Game",
        description: "Generated description for the game "
      )

      questions = Trivia::MultipleChoiceAvailableQuestion.order("random()").first(100)

      5.times do |index|
        @round = @game.rounds.build(
          status: :draft,
          leaderboard_size: @game.leaderboard_size,
          start_date: (1+index).hours.from_now,
          complexity: 1
        )

        10.times do |index|
          available_question = questions.pop

          MultipleChoiceQuestion.create!(
            round: @round,
            question_order: 1 + index,
            available_question: available_question,
            time_limit: available_question.time_limit,
            cooldown_period: available_question.cooldown_period,
          )
        end
        @round.save!
      end
    end
  end
end
