module Admin
  class BadgesController < Admin::ApplicationController
    private

      def valid_action?(name, resource = resource_class)
        name == "index" || current_user.super_admin?
      end
  end
end
