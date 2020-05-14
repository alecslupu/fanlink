module Trivia
  module GameStatus
    class RoundStartAnnouncementJob < ::ApplicationJob
      queue_as :trivia

      def perform(round_id, game_id, round_order, time)
        Push::Trivia.new.round_announcement_push(round_id, game_id, round_order, time)
      end
    end
  end
end
