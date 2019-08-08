class PersonQuizPolicy < ApplicationPolicy

  protected
    def module_name
      "courseware"
    end
  class Scope < Scope
    def resolve
      super.for_product(ActsAsTenant.current_tenant)
    end
  end
end
