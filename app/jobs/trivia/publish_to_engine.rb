# frozen_string_literal: true

module Trivia
  class PublishToEngine < ::ApplicationJob
    queue_as :trivia

    def perform(game_id)
      url = Rails.application.secrets.trivia_engine_url
      HTTParty.post(url,
        body: { game_id: game_id }.to_json,
        headers: {
          'Accept-Encoding': 'application/javascript',
          'Content-Type': 'application/json',
          'trivia-api-key': 'testing'
        },
        logger: Rails.logger, log_level: :debug, log_format: :curl
      )

      Rails.logger.debug('Got here')
    end
  end
end

