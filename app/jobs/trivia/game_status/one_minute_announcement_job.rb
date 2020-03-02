module Trivia
  module GameStatus
    class OneMinuteAnnouncementJob  < Struct.new(:round_id, :game_id, :round_order)
      def perform
        Push::Trivia.new.round_announcement_push(round_id, game_id, round_order, "1 minute")
      end
    end
  end
end
