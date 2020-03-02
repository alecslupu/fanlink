module Push
  class Trivia < BasePush

    def round_announcement_push(round_id, game_id, round_order, time)
      game = ::Trivia::Game.find(game_id)
      round = ::Trivia::Round.find(round_id)
      android_data = {
        game_id: game_id,
        round_id: round_id,
        type: "service",
        action: "trivia_round_start",
        short_name: game.short_name,
        start_date: round.start_date,
        round_order: round_order
      }

      time_to_live = 60
      android_topic_notification_push(android_data, time_to_live, "trivia_game_#{game_id}_android")

      ios_topic_notification_push(
        "Caned Trivia",
        "Next round will begin in #{time}",
        nil,
        60,
        "trivia_game_#{game_id}_ios",
        context: "trivia_round_start",
        game_id: game_id,
        round_id: round_id,
        start_date: round.start_date,
        round_order: round_order
      )
    end
  end
end
