module Trivia
  class GamePolicy < ApplicationPolicy
    def generate_game_action?
      true
    end

    class Scope < ApplicationPolicy::Scope
      def resolve
        # super.for_product(ActsAsTenant.current_tenant).includes(rounds: [questions: [ :available_question => :available_answers ]])
	super.for_product(ActsAsTenant.current_tenant)
      end
    end
  end
end
