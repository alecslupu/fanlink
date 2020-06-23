# frozen_string_literal: true

module Push
  class Trivia < BasePush

    def round_announcement_push(round_id, game_id, round_order, time)
      game = ::Trivia::Game.find(game_id)
      round = ::Trivia::Round.find(round_id)

      android_data = {
        type: 'service',
        action: 'trivia_round_start',
        short_name: game.short_name,
        start_date: round.start_date,
        round_order: round_order,
        deep_link: "#{game.product.internal_name}://trivia/game/#{game.id}/round/#{round.id}"
      }

      time_to_live = 0
      android_topic_notification_push(android_data, time_to_live, "trivia_game_#{game_id}_android")

      ios_topic_notification_push(
        'Caned Trivia',
        "Round #{round_order} of #{game.short_name} will begin in #{time}",
        0,
        "trivia_game_#{game_id}_ios",
        context: 'trivia_round_start',
        deep_link: "#{game.product.internal_name}://trivia/game/#{game.id}/round/#{round.id}"
      )
    end
  end
end
