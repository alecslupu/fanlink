# frozen_string_literal: true

class FollowingPolicy < UserModulePolicy
  class Scope < Scope
    def resolve
      scope.for_product(ActsAsTenant.current_tenant)
    end
  end
end
