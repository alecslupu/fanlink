class PersonCertcoursePolicy < ApplicationPolicy
  def destroy?
    false
  end

  def forget_action?
    true
  end

  def reset_progress_action?
    true
  end

  class Scope < Scope
    def resolve
      scope.all
    end
  end
end
