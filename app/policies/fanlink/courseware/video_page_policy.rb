# frozen_string_literal: true

module Fanlink
  module Courseware
    class VideoPagePolicy < CoursewareModulePolicy
      # class Scope < Scope
      #   def resolve
      #     super.for_product(ActsAsTenant.current_tenant)
      #   end
      # end
      class Scope < Scope
        def resolve
          super.includes(course_page: :course)
        end
      end
    end
  end
end
