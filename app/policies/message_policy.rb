class MessagePolicy < ApplicationPolicy

  def unhide_action?
    record.is_a?(Message) ? record.hidden? : false
  end

  def destroy?
    false
  end

  def create?
    false
  end
  # an admin should not be able to edit messages
  def edit?
    false
  end

  def hide_action?
    record.is_a?(Message) ? record.visible? : false
  end

  class Scope < ApplicationPolicy::Scope
    def resolve
      scope.publics.for_product(ActsAsTenant.current_tenant)
    end
  end
end
