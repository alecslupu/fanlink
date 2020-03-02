module Trivia
  module GameStatus
    class FifteenMinutesAnnouncementJob  < Struct.new(:round_id, :game_id, :round_order)
      def perform
        Push::Trivia.new.round_announcement_push(round_id, game_id, round_order, "15 minutes")
      end
    end
  end
end
