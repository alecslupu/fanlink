module Trivia
  class PublishToEngine < Struct.new(:game_id, :url)

    def perform
      url = Rails.application.secrets.trivia_engine_url
      HTTParty.post(url,
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

    def queue_name
      :trivia
    end
  end
end

