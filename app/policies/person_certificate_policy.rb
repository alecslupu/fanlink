class PersonCertificatePolicy < ApplicationPolicy
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
