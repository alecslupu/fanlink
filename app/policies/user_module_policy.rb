class UserModulePolicy < ApplicationPolicy
  protected
  def module_name
    "user"
  end
end
