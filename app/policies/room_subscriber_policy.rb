# frozen_string_literal: true
class RoomSubscriberPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      scope.for_product(ActsAsTenant.current_tenant)
    end
  end

  protected
  def module_name
    "portal_notification"
  end
end
