class MessagePolicy < ApplicationPolicy

  def unhide_action?
    record.hidden?
  end

  def destroy?
    false
  end

  def create?
    false
  end

  # an admin should not be able to edit messages

  def update?
    false
  end

  def edit?
    update?
  end

  def hide_action?
    record.visible?
  end

  class Scope < ApplicationPolicy::Scope
    def resolve
      scope.publics.for_product(ActsAsTenant.current_tenant)
    end
  end
end
