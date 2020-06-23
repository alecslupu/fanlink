# frozen_string_literal: true

class AutomatedNotificationPolicy < ApplicationPolicy
  protected
  def module_name
    'automated_notification'
  end
end
