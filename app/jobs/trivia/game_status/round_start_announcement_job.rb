module Trivia
  module GameStatus
    class RoundStartAnnouncementJob  < Struct.new(:round_id, :game_id, :round_order, :time)
      def perform
        Push::Trivia.new.round_announcement_push(round_id, game_id, round_order, time)
      end
    end
  end
end
