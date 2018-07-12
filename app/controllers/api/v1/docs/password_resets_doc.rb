class Api::V1::Docs::PasswordResetsDoc < ApiDoc
  doc_tag name: 'PasswordResets', desc: "Password Reset"
  route_base 'api/v1/password_resets'

  components do
  end

  # api :index, '' do
  #   desc ''
  #   query :, , desc: ''
  #   response_ref 200 => :
  # end

  api :create, 'Initiate a password reset.' do
    desc 'This is used to initiate a password reset. Product and email or username required. If email or username is not found, password reset will fail silently.'
    form! data: {
      :product! => { type: String, desc: 'Internal name of product.' },
      :email_or_username! => { type: String, desc: 'The person\'s email or username.' }
    }
    response 200, 'HTTP/1.1 200 Ok', :json, data: { message: 'Reset password instructions have been sent to your email, if it exists in our system' }
  end

  # api :list, '' do
  #   desc ''
  #   query :, , desc: ''
  #   response_ref 200 => :
  # end

  # api :show, '' do
  #   desc ''
  #   query :, , desc: ''
  #   response_ref 200 => :
  # end

  # api :update, '' do
  #   desc ''
  #   form! data: {
  #     :! => {

  #     }
  #   }
  #   response_ref 200 => :
  # end

  # api :destroy, '' do
  #   desc ''
  #   response_ref 200 => :OK
  # end



end
