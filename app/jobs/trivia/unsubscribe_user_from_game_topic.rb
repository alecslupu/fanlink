module Trivia
  class UnsubscribeUserFromGameTopic < Struct.new(:person_id, :game_id)
    def perform
      Push::BasePush.new.unsubscribe_user_from_topic(person_id, game_id)
    end
  end
end
