# module Admin
#   class ActionTypesController < Admin::ApplicationController
#     def destroy
#       if requested_resource.destroy
#         flash[:notice] = translate_with_resource("destroy.success")
#       else
#         flash[:alert] = requested_resource.errors.full_messages.first
#       end
#       redirect_to action: :index
#     end

#   private

#     def scoped_resource
#       ActionType.unscoped
#     end

#     def valid_action?(name, resource = resource_class, action_type = nil)
#       name == "index" || (current_user.super_admin? && (action_type.nil? || !action_type.in_use?))
#     end
#   end
# end
