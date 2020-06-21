# frozen_string_literal: true

class LevelPolicy < BadgeModulePolicy
  class Scope < ApplicationPolicy::Scope
    def resolve
      super.includes(:translations).for_product(ActsAsTenant.current_tenant)
    end
  end
end
