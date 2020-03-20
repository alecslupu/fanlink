module Trivia
  module RoundStatus
    class CloseJob < Struct.new(:round_id)

      def perform
        round = Trivia::Round.find(round_id)
        round.closed!

        round.reload.compute_leaderboard
      end
      def queue_name
        :trivia
      end
    end
  end
end
