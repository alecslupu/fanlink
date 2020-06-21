# frozen_string_literal: true

class QuestModulePolicy < ApplicationPolicy
  protected
  def module_name
    'quest'
  end
end
