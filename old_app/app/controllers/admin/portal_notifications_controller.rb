# module Admin
#   class PortalNotificationsController < Admin::ApplicationController

#     def create
#       params[:portal_notification] = params[:portal_notification].merge(product_id: ActsAsTenant.current_tenant.id)
#       resource = resource_class.new(resource_params)
#       authorize_resource(resource)
#       if resource.save
#         resource.enqueue_push
#         redirect_to(
#             [namespace, resource],
#             notice: translate_with_resource("create.success"),
#             )
#       else
#         render :new, locals: {
#             page: Administrate::Page::Form.new(dashboard, resource),
#         }
#       end

#     end

#     def new
#       resource = resource_class.new(send_me_at: (Time.zone.now + 1.hour).beginning_of_hour)
#       authorize_resource(resource)
#       render locals: {
#           page: Administrate::Page::Form.new(dashboard, resource),
#       }
#     end

#     def update
#       if requested_resource.update(resource_params)
#         requested_resource.update_push if requested_resource.previous_changes.keys.include?("send_me_at")
#         redirect_to(
#             [namespace, requested_resource],
#             notice: translate_with_resource("update.success"),
#             )
#       else
#         render :edit, locals: {
#             page: Administrate::Page::Form.new(dashboard, requested_resource),
#         }
#       end
#     end

#   private

#     def resource_params
#       params.require(:portal_notification).permit((dashboard.permitted_attributes << %i[ product_id ]).flatten)
#     end
#   end
# end
