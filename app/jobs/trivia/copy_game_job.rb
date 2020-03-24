module Trivia
  class CopyGameJob < Struct.new(:game_id)
    def perform
      game = Trivia::Game.find(game_id)
      ActsAsTenant.with_tenant(game.product) do
        game.copy_to_new
      end
    end
  end
end
