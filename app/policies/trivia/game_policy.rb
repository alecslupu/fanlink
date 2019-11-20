module Trivia
  class GamePolicy < TriviaModulePolicy
    def generate_game_action?
      has_permission? __method__
    end
  end
end
