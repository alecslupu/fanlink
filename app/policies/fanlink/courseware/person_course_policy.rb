# frozen_string_literal: true

module Fanlink
  module Courseware
    class PersonCoursePolicy < CoursewareModulePolicy
      def forget_action?
        super_admin? || has_permission?(:forget?)
      end

      def reset_progress_action?
        super_admin? || has_permission?(:reset?)
      end
    end
  end
end
