# frozen_string_literal: true

module Fanlink
  module Courseware
    class DownloadFilePagePolicy < CoursewareModulePolicy
      class Scope < Scope
        def resolve
          super.includes(course_page: :course)
        end
      end
    end
  end
end
