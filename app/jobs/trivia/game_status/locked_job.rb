module Trivia
  module GameStatus
    class LockedJob < Struct.new(:game_id)

      def perform
        game = Trivia::Game.find(game_id)
        game.locked!
      end

      def queue_name
        :trivia
      end
    end
  end
end
