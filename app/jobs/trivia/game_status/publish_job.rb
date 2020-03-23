module Trivia
  module GameStatus
    class PublishJob < Struct.new(:game_id)

      def perform
        game = Trivia::Game.find(game_id)
        # game.compute_gameplay_parameters
        # game.reload
        Delayed::Job.enqueue(::Trivia::PublishToEngine.new(game.id))
        Delayed::Job.enqueue(::Trivia::GameStatus::LockedJob.new(game.id), run_at: Time.at(game.start_date) - 10.minutes)
        Delayed::Job.enqueue(::Trivia::GameStatus::RunningJob.new(game.id), run_at: Time.at(game.start_date))
        Delayed::Job.enqueue(::Trivia::GameStatus::CloseJob.new(game.id), run_at: Time.at(game.end_date))
<<<<<<< HEAD
        round_order = 1

        game.rounds.each do |round|
          Delayed::Job.enqueue(::Trivia::GameStatus::RoundStartAnnouncementJob.new(round.id, game.id, round_order, "15 minutes"), run_at: Time.at(round.start_date) - 15.minute)
          Delayed::Job.enqueue(::Trivia::GameStatus::RoundStartAnnouncementJob.new(round.id, game.id, round_order, "1 minute"), run_at: Time.at(round.start_date) - 1.minute)
          round_order += 1
        end
=======

        game.rounds.each do |round|
          Delayed::Job.enqueue(::Trivia::RoundStatus::LockedJob.new(round.id), run_at: Time.at(round.start_date) - 30.minutes)
          Delayed::Job.enqueue(::Trivia::RoundStatus::RunningJob.new(round.id), run_at: Time.at(round.start_date))
          Delayed::Job.enqueue(::Trivia::RoundStatus::CloseJob.new(round.id), run_at: Time.at(round.end_date))
        end

      end
      def queue_name
        :trivia
>>>>>>> d8e66a86c873eff415796f5327ab75fda5a6b6c6
      end
    end
  end
end
