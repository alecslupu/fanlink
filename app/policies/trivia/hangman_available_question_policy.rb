module Trivia
  class HangmanAvailableQuestionPolicy < ApplicationPolicy
    class Scope < ApplicationPolicy::Scope
      def resolve
        scope.for_product(ActsAsTenant.current_tenant)
      end
    end
  end
end
