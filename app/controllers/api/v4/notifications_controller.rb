class Api::V4::NotificationsController < ApiController
  def create
    if current_user.pin_messages_from || current_user.product_account
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

  def notification_params
    params.require(:notification).permit(:body, :for_followers)
  end
end
