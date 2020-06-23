# frozen_string_literal: true

class ConfigItemPolicy < ApplicationPolicy
  def nested_set?
    edit?
  end

  class Scope < ApplicationPolicy::Scope
    def resolve
      scope.for_product(ActsAsTenant.current_tenant)
    end
  end

  protected

  def module_name
    'root'
  end

  def has_systen_permission?(permission)
    false
  end
end
