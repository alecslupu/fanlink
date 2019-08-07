class RoomPolicy < ApplicationPolicy
  def attributes_for(action)
    case action
    when :create
      { public: true, created_by_id: user.id }
    else
      {}
    end
  end
end
