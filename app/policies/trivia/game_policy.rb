module Trivia
  class GamePolicy < TriviaModulePolicy
    def generate_game_action?
      raise "Not implemented"
      true
    end
  end
end
