  module Trivia
  class GameGenerator
    attr_reader :game

    def initialize
    end

    def generate
      generate_game!
      questions = Trivia::AvailableQuestion.order("random()").first(100)

      5.times do |index|
        @round = game.rounds.build(
          status: :draft,
          leaderboard_size: game.leaderboard_size,
          start_date: (1+index).hours.from_now,
          complexity: 1
        )

        50.times do |index|
          available_question = questions.pop

          available_question.active_questions.create(
            round: @round,
            question_order: 1 + index,
            time_limit: available_question.time_limit + 10,
            cooldown_period: available_question.cooldown_period + 10,
          )
        end
        @round.save!
      end
    end

    def promote!
      game.published!
      game.rounds.reload.find_each(&:published!)
      game.compute_gameplay_parameters
    end

    private

    def generate_game!
      @game ||= Trivia::Game.create!(
        status: :draft,
        leaderboard_size: 10,
        long_name: "Generated Game #{DateTime.now.to_i}",
        short_name: "Generated Game",
        description: "Generated description for the game "
      )
    end
  end
end
