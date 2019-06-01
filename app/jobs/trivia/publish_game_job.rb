module Trivia
  class CloseGameJob < Struct.new(:game_id)

    def perform
      game = Trivia::Game.find(game_id)
      game.published!
    end
  end
end
