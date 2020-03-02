module Trivia
  module GameStatus
    class PublishJob < Struct.new(:game_id)

      def perform
        game = Trivia::Game.find(game_id)
        game.compute_gameplay_parameters
        Delayed::Job.enqueue(::Trivia::PublishToEngine.new(game.id))
        Delayed::Job.enqueue(::Trivia::GameStatus::LockedJob.new(game.id), run_at: Time.at(game.start_date) - 10.minutes)
        Delayed::Job.enqueue(::Trivia::GameStatus::RunningJob.new(game.id), run_at: Time.at(game.start_date))
        Delayed::Job.enqueue(::Trivia::GameStatus::CloseJob.new(game.id), run_at: Time.at(game.end_date))
        order = 1

        game.rounds.each do |round|
          Delayed::Job.enqueue(::Trivia::GameStatus::FifteenMinutesAnnouncementJob.new(round.id, game.id, round_order), run_at: Time.at(round.start_date - 15.minute))
          Delayed::Job.enqueue(::Trivia::GameStatus::OneMinuteAnnouncementJob.new(round.id, game.id, round_order), run_at: Time.at(round.start_date - 1.minute))
          order += 1
        end
      end
    end
  end
end
