module Trivia
  class TriviaPolicy < ApplicationPolicy

    class Scope < ApplicationPolicy::Scope
      def resolve
        scope.for_product(ActsAsTenant.current_tenant)
      end
    end
    protected
    def module_name
      "trivia"
    end
  end
end
