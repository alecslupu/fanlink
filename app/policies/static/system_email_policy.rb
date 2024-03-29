# frozen_string_literal: true

module Static
  class SystemEmailPolicy < ApplicationPolicy
    protected

    def module_name
      'root'
    end

    class Scope < Scope
      def resolve
        scope.for_product(ActsAsTenant.current_tenant)
      end
    end
  end
end
