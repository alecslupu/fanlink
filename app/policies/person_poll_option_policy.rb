class PersonPollOptionPolicy < ApplicationPolicy

  def create?
    false
  end

  def update?
    false
  end

  def destroy?
    false
  end

  class Scope < Scope
    def resolve
      super.for_product(ActsAsTenant.current_tenant)
    end
  end
end
