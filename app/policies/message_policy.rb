# frozen_string_literal: true

class MessagePolicy < ChatModulePolicy
  def create?
    false
  end

  def new?
    create?
  end

  def update?
    false
  end

  def unhide_action?
    record.is_a?(Message) ? record.hidden? && (super_admin? || has_permission?(:hide?)) : false
  end

  def edit?
    update?
  end

  def hide_action?
    record.is_a?(Message) ? record.visible? && (super_admin? || has_permission?(:hide?)) : false
  end

  class Scope < Scope
    def resolve
      scope.publics.for_product(ActsAsTenant.current_tenant)
    end
  end
end
