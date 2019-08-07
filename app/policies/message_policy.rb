class MessagePolicy < ApplicationPolicy

  def unhide_action?
    raise "not implemented"
    record.hidden?
  end

  def destroy?
    raise "not implemented"
    false
  end

  def create?
    raise "not implemented"
    false
  end
  # an admin should not be able to edit messages
  def edit?
    raise "not implemented"
    false
  end

  def hide_action?
    raise "not implemented"
    record.visible?
  end

  class Scope < ApplicationPolicy::Scope
    def resolve
      scope.publics.for_product(ActsAsTenant.current_tenant)
    end
  end
end
