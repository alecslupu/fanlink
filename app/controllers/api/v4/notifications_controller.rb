# frozen_string_literal: true


module Api
  module V4
    class NotificationsController < ApiController
      def create
        if vitalgroup_normal_user? || current_user.pin_messages_from || current_user.product_account
          @notification = Notification.new(notification_params.merge(person_id: current_user.id))
          if @notification.save
            @notification.notify
          else
            render_422 @notification.errors
          end
        else
          return render_401 _('You are not allowed to send notifications.')
        end
      end

      private

      def vitalgroup_normal_user?
        current_user.normal? && ActsAsTenant.current_tenant.internal_name == 'vitalgroup'
      end

      def notification_params
        params.require(:notification).permit(:body, :for_followers)
      end
    end
  end
end
