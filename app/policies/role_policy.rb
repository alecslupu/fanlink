# frozen_string_literal: true

class RolePolicy < ApplicationPolicy
  protected
  def module_name
    "root"
  end
end
