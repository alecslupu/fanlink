# frozen_string_literal: true

module Trivia
  class CopyGameJob < ApplicationJob
    queue_as :trivia

    def perform(game_id)
      game = Trivia::Game.find(game_id)
      ActsAsTenant.with_tenant(game.product) do
        game.copy_to_new
      end
    end
  end
end
