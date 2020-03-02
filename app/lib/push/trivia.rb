module Push
  class Trivia < BasePush

    def round_announcement_push(round_id, game_id, round_order)
      @target_person = mentioned_person
      game = Game.find(game_id)
      round = Round.find(round_id)

      android_data = {
        game_id: game_id,
        round_id: round_id,
        type: "service",
        action: "trivia_round_start",
        short_name: game.short_name,
        start_date: round.start_date,
        round_order: round_order
      }

      android_topic_notification_push(android_data, "60", "trivia_game_#{game_id}_android")

      # ios_token_notification_push(
      #   "Mention",
      #   "#{post_comment.person.username} mentioned you",
      #   nil,
      #   2419200,
      #   context: "trivia",
      #   deep_link: "#{post_comment.person.product.internal_name}://posts/#{post_comment.post.id}/comments"
      # )
    end
  end
end

