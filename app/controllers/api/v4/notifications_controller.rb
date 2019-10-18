class Api::V4::NotificationsController < ApiController
  def create
    if current_user.pin_messages_from || current_user.product_account
      @notification = Notification.new(notification_params)
      if @notification.save
        # params[:followers] ? receipents = current_user.followers : receipents = Person.where.not(id: current_user.id)

      else
        render_422 @notification.errors
      end
    else
      return render_401 _('You are not allowed to send notifications.')
    end
  end

  private

  def notification_params
    params.require(:notification).permit(:body, :for_followers, :person_id)
  end
end
