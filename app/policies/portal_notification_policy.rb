# frozen_string_literal: true
class PortalNotificationPolicy < ApplicationPolicy
  # def attributes_for(action)
  #   case action
  #   when :new
  #     {send_me_at: }
  #   when :create
  #     {trigger_admin_notification: true}
  #   when :update
  #     {trigger_admin_notification: true}
  #   else
  #     {}
  #   end
  # end
  protected
  def module_name
    "portal_notification"
  end
end
