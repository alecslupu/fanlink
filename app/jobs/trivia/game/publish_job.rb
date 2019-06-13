module Trivia
  module Game
    class PublishJob < Struct.new(:game_id)

      def perform
        game = Trivia::Game.find(game_id)
        game.compute_gameplay_parameters
        Delayed::Job.enqueue(::Trivia::PublishToEngine.new(self.id))
      end
    end
  end
end
