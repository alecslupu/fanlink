# frozen_string_literal: true

module Fanlink
  module Courseware
    class QuizPagePolicy < CoursewareModulePolicy
      class Scope < Scope
        def resolve
          scope.includes(:course_page => :course)
        end
      end
    end
  end
end
