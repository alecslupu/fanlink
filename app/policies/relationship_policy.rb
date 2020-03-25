class RelationshipPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      scope.for_product(ActsAsTenant.current_tenant)
    end
  end
end
