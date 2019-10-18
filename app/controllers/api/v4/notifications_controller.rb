# class Api::V4::NotificationsController < ApiController
# def notify
#   if current_user.pin_messages_from || current_user.product_account
#     receipents =
#   else
#     return render_401 _("You are not allowed to send notifications.")
#   end

#   private

#   def certificate_params
#     params.require(:notification).permit(:body, :flag)
#   end
# end
