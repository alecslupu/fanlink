# frozen_string_literal: true

class PostModulePolicy < ApplicationPolicy
  protected
  def module_name
    "post"
  end
end
