# frozen_string_literal: true

class PortalAccessPolicy < ApplicationPolicy
  class Scope < ApplicationPolicy::Scope
    def resolve
      super.for_product(ActsAsTenant.current_tenant)
    end
  end
end
