module Trivia
  module Game
    class RunningJob  < Struct.new(:game_id)

      def perform
        game = Trivia::Game.find(game_id)
        game.running!
      end
    end
  end
end
