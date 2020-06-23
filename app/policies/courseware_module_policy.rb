# frozen_string_literal: true

class CoursewareModulePolicy < ApplicationPolicy

  protected

  def module_name
    'courseware'
  end
end
