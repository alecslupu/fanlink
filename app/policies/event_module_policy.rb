# frozen_string_literal: true

class EventModulePolicy < ApplicationPolicy
  protected
  def module_name
    "event"
  end
end
