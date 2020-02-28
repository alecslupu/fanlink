module Trivia
  module GameStatus
    class PublishJob < Struct.new(:game_id)

      def perform
        game = Trivia::Game.find(game_id)
        game.compute_gameplay_parameters
        game.reload
        Delayed::Job.enqueue(::Trivia::PublishToEngine.new(game.id))
        Delayed::Job.enqueue(::Trivia::GameStatus::LockedJob.new(game.id), run_at: Time.at(game.start_date) - 10.minutes)
        Delayed::Job.enqueue(::Trivia::GameStatus::RunningJob.new(game.id), run_at: Time.at(game.start_date))
        Delayed::Job.enqueue(::Trivia::GameStatus::CloseJob.new(game.id), run_at: Time.at(game.end_date))

        game.rounds.each do |round|
          Delayed::Job.enqueue(::Trivia::RoundStatus::LockedJob.new(round.id), run_at: Time.at(round.start_date) - 30.minutes)
          Delayed::Job.enqueue(::Trivia::RoundStatus::RunningJob.new(round.id), run_at: Time.at(round.start_date))
          Delayed::Job.enqueue(::Trivia::RoundStatus::CloseJob.new(round.id), run_at: Time.at(round.end_date))
        end

      end
    end
  end
end
