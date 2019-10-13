class ConfigItemPolicy < ApplicationPolicy
  def nested_set?
    update?
  end

  def create?
    false
  end

  def new?
    create?
  end
  protected

  def module_name
    "product"
  end
end
