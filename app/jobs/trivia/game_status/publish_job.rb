module Trivia
  module GameStatus
    class PublishJob < ::ApplicationJob
      queue_as :trivia

      def perform(game_id)
        game = Trivia::Game.find(game_id)
        game.compute_gameplay_parameters
        game.reload

        ::Trivia::PublishToEngine.perform_later(game.id)
        ::Trivia::GameStatus::LockedJob.set(wait_until: Time.at(game.start_date) - 10.minutes).perform_later(game.id)
        ::Trivia::GameStatus::RunningJob.set(wait_until: Time.at(game.start_date)).perform_later(game.id)
        ::Trivia::GameStatus::CloseJob.set(wait_until: game.end_date).perform_later(game.id)

        round_order = 1

        game.rounds.each do |round|
          ::Trivia::RoundStatus::LockedJob.set(wait_until: Time.at(round.start_date) - 30.minutes).perform_later(round.id)
          ::Trivia::RoundStatus::RunningJob.set(wait_until: Time.at(round.start_date)).perform_later(round.id)
          ::Trivia::RoundStatus::CloseJob.set(wait_until: Time.at(round.end_date)).perform_later(round.id)
          ::Trivia::RoundStatus::RoundStartAnnouncementJob.set(wait_until: Time.at(round.start_date) - 15.minutes).perform_later(round.id, game.id, round_order, "15 minutes")
          ::Trivia::RoundStatus::RoundStartAnnouncementJob.set(wait_until: Time.at(round.start_date) - 1.minute).perform_later(round.id, game.id, round_order, "1 minute")
          round_order += 1
        end

      end
    end
  end
end
