class PortalNotificationPolicy < ApplicationPolicy

  def create?
    false
  end
  alias :new? :create?


  def update?
    true
  end
  alias :edit? :update?

  class Scope < Scope

  end
end
