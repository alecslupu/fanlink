# frozen_string_literal: true

module Fanlink
  module Courseware
    class QuizPagePolicy < CoursewareModulePolicy
      class Scope < Scope
        def resolve
          scope.for_product(ActsAsTenant.current_tenant).includes(:certcourse_page => :certcourse)
        end
      end
    end
  end
end
