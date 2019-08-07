class MessageReportPolicy < ApplicationPolicy
  # a message report should not be edited by an admin
  def update?
    raise "not implemented"
    false
  end

  def create?
    raise "not implemented"
    false
  end

  def show?
    raise "not implemented"
    true
  end

  # a message report should not be deleted by an admin
  def destroy?
    raise "not implemented"
    false
  end

  def hide_message_action?
    raise "not implemented"
    !["message_hidden"].include?(record.status)
  end

  def ignore_action?
    raise "not implemented"
    !["no_action_needed"].include?(record.status)
  end

  def reanalyze_action?
    raise "not implemented"
    !["pending"].include?(record.status)
  end

  class Scope < ApplicationPolicy::Scope
    def resolve
      super.for_product(ActsAsTenant.current_tenant)
    end
  end
end
