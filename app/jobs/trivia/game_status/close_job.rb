module Trivia
  module GameStatus
    class CloseJob < ::ApplicationJob
      queue_as :trivia

      def perform(game_id)
        game = Trivia::Game.find(game_id)
        game.closed!

        game.reload.compute_leaderboard
      end
    end
  end
end
