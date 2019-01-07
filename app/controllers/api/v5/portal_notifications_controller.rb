class Api::V5::PortalNotificationsController < Api::V4::PortalNotificationsController
  def index
    @portal_notifications = paginate(PortalNotification.all)
    return_the @portal_notifications, handler: 'jb'
  end

  def show
    return_the @portal_notification, handler: 'jb'
  end
end
