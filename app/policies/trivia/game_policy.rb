module Trivia
  class GamePolicy < ApplicationPolicy
    def generate_game_action?
      true
    end
  end
end
