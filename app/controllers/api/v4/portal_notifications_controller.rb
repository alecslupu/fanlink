# frozen_string_literal: true

module Api
  module V4
    class PortalNotificationsController < Api::V3::PortalNotificationsController
      def index
        @portal_notifications = paginate(PortalNotification.all)
        return_the @portal_notifications, handler: tpl_handler
      end

      def show
        return_the @portal_notification, handler: tpl_handler
      end

      def create
        @portal_notification = PortalNotification.create(portal_params)
        if @portal_notification.valid?
          @portal_notification.enqueue_push
          return_the @portal_notification, handler: tpl_handler, using: :show
        else
          render_422 @portal_notification.errors
        end
      end

      def update
        if params.has_key?(:portal_notification)
          if @portal_notification.update(portal_params)
            @portal_notification.update_push
            return_the @portal_notification, handler: tpl_handler, using: :show
          else
            render_422 @portal_notification.errors
          end
        else
          return_the @portal_notification, handler: tpl_handler, using: :show
        end
      end

      protected

      def tpl_handler
        :jb
      end
    end
  end
end
