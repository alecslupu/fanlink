class PostPolicy < PostModulePolicy
  def attributes_for(action)
    case action
    when :create
      { person_id: user.id }
    else
      {}
    end
  end

  class Scope < ApplicationPolicy::Scope
    def resolve
      super.for_product(ActsAsTenant.current_tenant)
    end
  end
end
