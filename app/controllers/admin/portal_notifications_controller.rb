module Admin
  class PortalNotificationsController < Admin::ApplicationController

    def create
      params[:portal_notification] = params[:portal_notification].merge(person_id: current_user.id, product_id: ActsAsTenant.current_tenant.id)
      super
    end

    private

    def resource_params
      params.require(:portal_notification).permit((dashboard.permitted_attributes << %i[ person_id product_id ]).flatten)
    end
  end
end
