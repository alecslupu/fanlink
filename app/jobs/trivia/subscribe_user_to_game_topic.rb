module Trivia
  class SubscribeUserToGameTopic < Struct.new(:person_id, :game_id)
    def perform
      Push::BasePush.new.subscribe_user_to_topic(person_id, game_id)
    end
  end
end
