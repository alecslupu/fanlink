class RolePolicy < ApplicationPolicy
  def attributes_for(action)
    {}
  end

  protected
  def module_name
    "root"
  end

  def has_systen_permission?(permission)
    false
  end
end
