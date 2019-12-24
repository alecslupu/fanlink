module Trivia
  module GameStatus
    class PublishJob < Struct.new(:game_id)

      def perform
        game = Trivia::Game.find(game_id)
        game.compute_gameplay_parameters
        Delayed::Job.enqueue(::Trivia::PublishToEngine.new(game.id))
        Delayed::Job.enqueue(::Trivia::GameStatus::LockedJob.new(game.id), run_at: Time.zone.at(game.start_date) - 10.minutes)
        Delayed::Job.enqueue(::Trivia::GameStatus::RunningJob.new(game.id), run_at: Time.zone.at(game.start_date))
        Delayed::Job.enqueue(::Trivia::GameStatus::CloseJob.new(game.id), run_at: Time.zone.at(game.end_date))
      end
    end
  end
end
