class Api::V4::Courseware::Client::PeopleController < ApiController
  def index
    if current_user.client?
      id = Person.last.nil? ? 1 : Person.last.id
      @assignees = [Person.create(id: id + 1,username: "Miguel270419", username_canonical: "miguel270419", email: "miguel2704@outlook.es", name: nil, product_id: current_user.product.id, crypted_password: nil, salt: nil, facebookid: "10212341639468514", facebook_picture_url: "https://platform-lookaside.fbsbx.com/platform/profilepic/?asid=10212341639468514&height=50&width=50&ext=1538791556&hash=AeSKCN5c-adZhVaF", picture_file_name: nil, picture_content_type: nil, picture_file_size: nil, picture_updated_at: nil, do_not_message_me: false, pin_messages_from: false, auto_follow: false, role: "normal", reset_password_token: nil, reset_password_token_expires_at: nil, reset_password_email_sent_at: nil, product_account: false, chat_banned: false, designation: {}, recommended: false, gender: "unspecified", birthdate: nil, city: nil, country_code: nil, biography: nil, tester: false, terminated: false, terminated_reason: nil, deleted: false)]
      @assignees << Person.create(id: id + 2,username: "KarlaAlcantar", username_canonical: "karlaalcantar", email: "innakarla@hotmail.com", name: nil, product_id: current_user.product.id, crypted_password: "$2a$10$Cc4iJFVzRFy4G61oy.y3fuJ2Hv6VaDrwyS1seO/8xzyA7cpKlRwsO", salt: "V6bnpgfFuAxBLvSQiNYa", facebookid: nil, facebook_picture_url: nil, picture_file_name: "image.jpg", picture_content_type: "image/jpeg", picture_file_size: 61619, picture_updated_at: "2018-09-04 19:16:41", do_not_message_me: false, pin_messages_from: false, auto_follow: false, role: "normal", reset_password_token: nil, reset_password_token_expires_at: nil, reset_password_email_sent_at: nil, product_account: false, chat_banned: false, designation: {}, recommended: false, gender: "unspecified", birthdate: nil, city: nil, country_code: nil, biography: nil, tester: false, terminated: false, terminated_reason: nil, deleted: false)
      return_the @assignees, handler: :jb
    else
      render_401 _("You must have 'client' role to access this feature.")
    end
  end

  # def index
  #   if current_user.client?
  #     @assignees = current_user.assignees
  #     return_the @assignees, handler: :jb
  #   else
  #     render_401 _("You must have 'client' role to access this feature.")
  #   end
  # end
end
