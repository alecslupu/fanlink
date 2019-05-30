module Trivia
  class PublishToEngine < Struct.new(:game_id)

    def perform
      HTTParty.post(
        'https://stg-fl-trivia.herokuapp.com/api/publish_game',
        body: { game_id: game_id }.to_json,
        headers: {
          'Accept-Encoding': "application/javascript",
          'Content-Type': "application/json",
          'trivia-api-key': "testing"
        },
        logger: Rails.logger, log_level: :debug, log_format: :curl
      )

      Rails.logger.debug("Got here")
    end
  end
end
