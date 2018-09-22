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
      return_the @portal_notification
    else
      render_422 @portal_notification.errors
    end
  end

  def update
    if @portal_notification.update_attributes(portal_params)
      return_the @portal_notification
    else
      render_422 @portal_notification.errors
    end
  end

  def destroy
  end

private
  def portal_params
    params.require(:portal_notifications).permit(:body, :send_me_at, :sent_status)
  end
end
