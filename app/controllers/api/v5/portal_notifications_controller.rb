class Api::V5::PortalNotificationsController < Api::V4::PortalNotificationsController
  def index
    @portal_notifications = paginate(PortalNotification.all)
    return_the @portal_notifications, handler: tpl_handler
  end

  def show
    return_the @portal_notification, handler: tpl_handler
  end
end
