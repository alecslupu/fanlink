# frozen_string_literal: true

class VideoPagePolicy < CoursewareModulePolicy
  # class Scope < Scope
  #   def resolve
  #     super.for_product(ActsAsTenant.current_tenant)
  #   end
  # end
  class Scope < Scope
    def resolve
      super.for_product(ActsAsTenant.current_tenant).includes(certcourse_page: :certcourse)
    end
  end
end
