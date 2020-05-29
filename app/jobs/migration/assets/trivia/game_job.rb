module Migration
  module Assets
    module Trivia

      class GameJob < ::Migration::Assets::ApplicationJob
        queue_as :migration

        def perform(game_id)
          require 'open-uri'
          game = ::Trivia::Game.find(game_id)
          url = paperclip_asset_url(game, "picture", game.product)
          game.picture.attach(io: open(url), filename: game.picture_file_name, content_type: game.picture_content_type)
        end
      end
    end
  end
end
