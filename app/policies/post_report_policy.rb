class PostReportPolicy < PostModulePolicy
  # a message report should not be edited by an admin
  def update?
    false
  end

  # a message report should not be deleted by an admin
  def destroy?
    false
  end

  class Scope < ApplicationPolicy::Scope
    def resolve
      super.for_product(ActsAsTenant.current_tenant)
    end
  end
end
