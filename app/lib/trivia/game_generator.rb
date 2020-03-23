module Trivia
  class GameGenerator
    attr_reader :game

    def initialize
    end

    def generate
      generate_game!

      start_date = 5.minutes.from_now
      questions = Trivia::AvailableQuestion.published.order(Arel.sql "random()").first(150)

      5.times do |index|
        start_date = game.rounds.reload.last.end_date + 5.minutes unless index.zero?
        round = game.rounds.build(
          status: :draft,
          leaderboard_size: game.leaderboard_size,
          start_date: start_date,
          complexity: 1
        )
        generate_question_set(round, questions)
        round.save!
        round.compute_gameplay_parameters
      end
    end

    def promote!
      game.published!
      game.rounds.reload.find_each(&:published!)
    end

    private

    def generate_question_set(round, questions)
      10.times do |index|
        available_question = questions.pop
        available_question.active_questions.create(
          round: round,
          question_order: 1 + index,
          time_limit: available_question.time_limit + 10,
          cooldown_period: available_question.cooldown_period + (index == 9 ? 0 : 10),
        )
      end
    end

    def generate_game!
      @game ||= Trivia::Game.create!(
        status: :draft,
        leaderboard_size: 10,
        long_name: "Generated Game #{DateTime.now.to_i}",
        short_name: "Generated Game",
        description: "Generated description for the game ",
        start_date: 5.minutes.from_now
      )
    end
  end
end
