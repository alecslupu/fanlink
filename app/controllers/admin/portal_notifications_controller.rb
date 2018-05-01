module Admin
  class PortalNotificationsController < Admin::ApplicationController

    def create
      params[:portal_notification] = params[:portal_notification].merge(person_id: current_user.id, product_id: ActsAsTenant.current_tenant.id)
      super
    end

    def new
      resource = resource_class.new(send_me_at: (Time.zone.now + 1.hour).beginning_of_hour)
      authorize_resource(resource)
      render locals: {
          page: Administrate::Page::Form.new(dashboard, resource),
      }
    end
    private

    def resource_params
      params.require(:portal_notification).permit((dashboard.permitted_attributes << %i[ person_id product_id ]).flatten)
    end
  end
end
