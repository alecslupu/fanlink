class RoomPolicy < ApplicationPolicy


  def attributes_for(action)
    case action
    when :create
      { public: true, created_by_id: user.id }
    else
      {}
    end
  end

  class Scope < ApplicationPolicy::Scope
    # def resolve
    #   super.for_product(ActsAsTenant.current_tenant)
    # end
  end
end
