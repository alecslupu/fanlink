class Api::V4::NotificationsController < ApiController
  def create
    if current_user.pin_messages_from || current_user.product_account
      params[:followers] ? receipents = current_user.followers : recepents = Person.where.not(id: current_user.id)
        receipents = current_user.followers

      end
    else
      return render_401 _('You are not allowed to send notifications.')
    end
  end

  private

  def certificate_params
    params.require(:notification).permit(:body, :followers)
  end
end
