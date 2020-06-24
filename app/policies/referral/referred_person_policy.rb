# frozen_string_literal: true

module Referral
  class ReferredPersonPolicy < ApplicationPolicy
    def deny
      false
    end

    alias show? deny
    alias create? deny
    alias destroy? deny
    alias update? deny

    def purchase_report_action?
      true
    end

    def report_action?
      true
    end

    class Scope < Scope
      def resolve
        super.joins(:inviter => :referral_code)
      end
    end

    protected

    def module_name
      'root'
    end
  end
end
