class PersonCertcoursePolicy < CoursewareModulePolicy
  def forget_action?
    super_admin? || has_permission?(:forget?)
  end

  def reset_progress_action?
    super_admin? || has_permission?(:reset?)
  end

  class Scope < Scope
    def resolve
      super.for_product(ActsAsTenant.current_tenant)
    end
  end
end
