# frozen_string_literal: true

module Trivia
  module GameStatus
    class LockedJob < ::ApplicationJob
      queue_as :trivia

      def perform(game_id)
        game = Trivia::Game.find(game_id)
        game.locked!
      end

      def queue_name
        :trivia
      end
    end
  end
end
