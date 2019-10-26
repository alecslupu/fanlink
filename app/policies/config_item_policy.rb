class ConfigItemPolicy < ApplicationPolicy
  protected
  def module_name
    "root"
  end

  def super_admin?
    false
  end
end
