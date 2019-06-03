module Trivia
  class LockGameJob < Struct.new(:game_id)

    def perform
      game = Trivia::Game.find(game_id)
      game.locked!
    end
  end
end
