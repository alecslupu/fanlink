module Trivia
  module RoundStatus
    class LockedJob < Struct.new(:round_id)

      def perform
        round = Trivia::Round.find(round_id)
        round.locked!
      end

      def queue_name
        :trivia
      end

    end
  end
end
