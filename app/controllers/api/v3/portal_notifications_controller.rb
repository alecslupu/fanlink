class Api::V3::PortalNotificationsController < ApiController
  before_action :super_admin_only
  load_up_the PortalNotification, only: %i[ show update ]
  def index
    @portal_notifications = paginate(PortalNotification.all)
    return_the @portal_notifications
  end

  def show
    return_the @portal_notification
  end

  def create
    @portal_notification = PortalNotification.create(portal_params)
    if @portal_notification.valid?
      @portal_notification.enqueue_push
      return_the @portal_notification
    else
      render_422 @portal_notification.errors
    end
  end

  def update
    if params.has_key?(:portal_notification)
      if @portal_notification.update(portal_params)
        @portal_notification.update_push
        return_the @portal_notification
      else
        render_422 @portal_notification.errors
      end
    else
      return_the @portal_notification
    end
  end

  def destroy
  end

private
  def portal_params
    params.require(:portal_notifications).permit(:body, :send_me_at, :sent_status)
  end
end
