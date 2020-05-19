module Trivia
  module GameStatus
    class RunningJob < ::ApplicationJob
      queue_as :trivia

      def perform(game_id)
        game = Trivia::Game.find(game_id)
        game.running!
      end
    end
  end
end
