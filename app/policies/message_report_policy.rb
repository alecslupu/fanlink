class MessageReportPolicy < ChatModulePolicy

  # a message report should not be edited by an admin
  def update?
    false
  end

  # This should be false as result of FLAPI-1081
  def create?
    false
  end

  # a message report should not be deleted by an admin
  def destroy?
    false
  end

  def hide_message_action?
    !["message_hidden"].include?(record.status) && has_permission?(:hide?)
  end

  def ignore_message_action?
    !["no_action_needed"].include?(record.status)&& has_permission?(:ignore?)
  end

  def reanalyze_message_action?
    !["pending"].include?(record.status) && has_permission?(:hide?)
  end

  class Scope < ApplicationPolicy::Scope
    def resolve
      super.for_product(ActsAsTenant.current_tenant)
    end
  end
end
