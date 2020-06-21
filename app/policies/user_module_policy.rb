# frozen_string_literal: true

class UserModulePolicy < ApplicationPolicy
  protected
  def module_name
    'user'
  end
end
