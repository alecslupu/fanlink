module Trivia
  module RoundStatus
    class LockedJob < ::ApplicationJob
      queue_as :trivia

      def perform(round_id)
        round = Trivia::Round.find(round_id)
        round.locked!
      end
    end
  end
end
