# frozen_string_literal: true

class PostReportPolicy < PostModulePolicy
  # a message report should not be edited by an admin
  def update?
    false
  end

  # a message report should not be deleted by an admin
  def destroy?
    false
  end

  # This should be false as result of FLAPI-1081
  def create?
    false
  end

  def hide_post_report_action?
    !['message_hidden'].include?(record.status) && has_permission?(:hide?)
  end

  def ignore_post_report_action?
    !['no_action_needed'].include?(record.status) && has_permission?(:ignore?)
  end

  def reanalyze_post_report_action?
    !['pending'].include?(record.status) && has_permission?(:hide?)
  end


  class Scope < ApplicationPolicy::Scope
    def resolve
      super.for_product(ActsAsTenant.current_tenant)
    end
  end
end
