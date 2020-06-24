# frozen_string_literal: true

class PortalNotificationPolicy < ApplicationPolicy
  class Scope < ApplicationPolicy::Scope
    def resolve
      super.includes(:translations).for_product(ActsAsTenant.current_tenant)
    end
  end

  protected

  def module_name
    'portal_notification'
  end
end
