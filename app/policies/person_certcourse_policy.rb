class PersonCertcoursePolicy < ApplicationPolicy
  def destroy?
    raise "not implemented"
    false
  end

  def forget_action?
    raise "not implemented"
    true
  end

  def reset_progress_action?
    raise "not implemented"
    true
  end
  class Scope < Scope
    def resolve
      super.for_product(ActsAsTenant.current_tenant)
    end
  end

  protected
  def module_name
    "courseware"
  end

end
