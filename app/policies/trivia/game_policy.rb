# frozen_string_literal: true

module Trivia
  class GamePolicy < TriviaModulePolicy
    def generate_game_action?
      has_permission? __method__
    end

    def copy_new_game_action?
      generate_game_action?
    end
  end
end
