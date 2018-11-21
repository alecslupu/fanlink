class Api::V4::PortalNotificationsController < Api::V3::PortalNotificationsController
  def index
    @portal_notifications = paginate(PortalNotification.all)
    return_the @portal_notifications, handler: 'jb'
  end

  def show
    return_the @portal_notification, handler: 'jb'
  end

  def create
    @portal_notification = PortalNotification.create(portal_params)
    if @portal_notification.valid?
      @portal_notification.enqueue_push
      return_the @portal_notification, handler: 'jb', using: :show
    else
      render_422 @portal_notification.errors
    end
  end

  def update
    if params.has_key?(:portal_notification)
      if @portal_notification.update_attributes(portal_params)
        @portal_notification.update_push
        return_the @portal_notification, handler: 'jb', using: :show
      else
        render_422 @portal_notification.errors
      end
    else
      return_the @portal_notification, handler: 'jb', using: :show
    end
  end
end
