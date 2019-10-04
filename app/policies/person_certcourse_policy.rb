class PersonCertcoursePolicy < CoursewareModulePolicy
  def forget_action?
    super_admin? || access.send([module_name, "forget?"].join("_").to_sym)
  end

  def reset_progress_action?
    super_admin? || access.send([module_name, "reset?"].join("_").to_sym)
  end

  class Scope < Scope
    def resolve
      super.for_product(ActsAsTenant.current_tenant)
    end
  end
end
