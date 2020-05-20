# frozen_string_literal: true
class PersonQuizPolicy < CoursewareModulePolicy
  class Scope < Scope
    def resolve
      super.for_product(ActsAsTenant.current_tenant)
    end
  end
end
