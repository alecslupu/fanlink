class PortalAccessPolicy < ApplicationPolicy
  def attributes_for(action)
    {}
  end

  class Scope < ApplicationPolicy::Scope
    def resolve
      super.for_product(ActsAsTenant.current_tenant)
    end
  end
end
