class MessageReportPolicy < ApplicationPolicy

  # a message report should not be edited by an admin
  def update?
    false
  end

  def create?
    false
  end

  def show?
    true
  end

  # a message report should not be deleted by an admin
  def destroy?
    false
  end

  def hide_message_action?
    !["message_hidden"].include?(record.status)
  end

  def ignore_action?
    !["no_action_needed"].include?(record.status)
  end

  def reanalyze_action?
    !["pending"].include?(record.status)
  end

  class Scope < ApplicationPolicy::Scope
    def resolve
      super.for_product(ActsAsTenant.current_tenant)
    end
  end
end
