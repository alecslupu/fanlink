# frozen_string_literal: true

class BadgeModulePolicy < ApplicationPolicy
  protected

  def module_name
    'badge'
  end
end
