class PortalNotificationPolicy < ApplicationPolicy
  def create?
    raise "not implemented"
    true
  end
  alias :new? :create?

  def update?
    raise "not implemented"
    true
  end
  alias :edit? :update?

  def attributes_for(action)
    case action
    when :new
      { send_me_at: (Time.zone.now + 1.hour).beginning_of_hour }
    when :create
      { trigger_admin_notification: true }
    when :update
      { trigger_admin_notification: true }
    else
      {}
    end
  end

  class Scope < Scope
  end
end
