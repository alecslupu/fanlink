# frozen_string_literal: true

module Fanlink
  module Courseware
    class PersonQuizPageAnswerPolicy < CoursewareModulePolicy

      class Scope < Scope
        def resolve
          super.for_product(ActsAsTenant.current_tenant)
        end
      end
    end
  end
end
