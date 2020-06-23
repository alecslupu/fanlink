# frozen_string_literal: true

class ChatModulePolicy < ApplicationPolicy
  protected
  def module_name
    'chat'
  end
end
