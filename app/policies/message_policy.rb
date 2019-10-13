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

  def edit?
    update?
  end
  
  def unhide_action?
    record.is_a?(Message) ? record.hidden? && (super_admin? || access.send([module_name, "hide?"].join("_").to_sym)) : false
  end

  def hide_action?
    record.is_a?(Message) ? record.visible? && (super_admin? || access.send([module_name, "hide?"].join("_").to_sym)) : false
  end

  class Scope < Scope
    def resolve
      scope.publics.for_product(ActsAsTenant.current_tenant)
    end
  end
end
