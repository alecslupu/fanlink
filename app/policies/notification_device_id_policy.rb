# frozen_string_literal: true

class NotificationDeviceIdPolicy < ApplicationPolicy

  class Scope < ApplicationPolicy::Scope
    def resolve
      super.for_product(ActsAsTenant.current_tenant)
    end
  end


  protected
  def module_name
    "portal_notification"
  end
end
