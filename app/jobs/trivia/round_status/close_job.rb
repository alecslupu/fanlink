# frozen_string_literal: true
module Trivia
  module RoundStatus
    class CloseJob < ::ApplicationJob
      queue_as :trivia

      def perform(round_id)
        round = Trivia::Round.find(round_id)
        round.closed!

        round.reload.compute_leaderboard
      end
    end
  end
end
