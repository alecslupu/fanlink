class ConfigItemPolicy < ApplicationPolicy

  class Scope < ApplicationPolicy::Scope
    def resolve
      scope.for_product(ActsAsTenant.current_tenant)
    end
  end

  protected
  def module_name
    "root"
  end

  def super_admin?
    false
  end
end
