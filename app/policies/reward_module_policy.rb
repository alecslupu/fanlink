# frozen_string_literal: true

class RewardModulePolicy < ApplicationPolicy
  protected
  def module_name
    'reward'
  end
end
