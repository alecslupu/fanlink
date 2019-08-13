class ConfigItemPolicy < ApplicationPolicy
  def nested_set?
    update?
  end
  protected

  def module_name
    "product"
  end
end
