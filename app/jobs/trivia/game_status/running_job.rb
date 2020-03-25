module Trivia
  module GameStatus
    class RunningJob  < Struct.new(:game_id)

      def perform
        game = Trivia::Game.find(game_id)
        game.running!
      end

      def queue_name
        :trivia
      end
    end
  end
end
