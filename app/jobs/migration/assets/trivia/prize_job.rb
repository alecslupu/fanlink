module Migration
  module Assets
    module Trivia
      class PrizeJob < ::Migration::Assets::ApplicationJob
        queue_as :migration

        def perform(prize_id)
          require 'open-uri'
          prize = ::Trivia::Prize.find(prize_id)
          url = paperclip_asset_url(prize, 'photo', prize.product)
          prize.photo.attach(io: open(url), filename: prize.photo_file_name, content_type: prize.photo_content_type)
        end
      end
    end
  end
end
