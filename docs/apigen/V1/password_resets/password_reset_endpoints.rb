# FanlinkApi::API.endpoint :get_password_resets do
#   method :get
#   tag 'People'
#   path '/password_resets'
#   output :success do
#     status 200
#     type :object do
#       password_resets :array do
#         type :password_reset_json
#       end
#     end
#   end

#   output :unauthorized do
#     status 401
#     type :object do
#       errors :object do
#         base :array do
#           type :string
#         end
#       end
#     end
#     description 'User is not authorized to access this endpoint.'
#   end

#   output :server_error do
#     status 500
#     type :object do
#       errors :object do
#         base :array do
#           type :string
#         end
#       end
#     end
#     description 'Internal Server Error. Server threw an unrecoverable error. Create a ticket with any form fields you we\'re trying to send, the URL, API version number and any steps you took so that it can be replicated.'
#   end
# end

# FanlinkApi::API.endpoint :get_a_password_reset do
#   method :get
#   tag 'People'
#   path '/password_resets/{id}' do
#     id :int32
#   end
#   output :success do
#     status 200
#     type :object do
#       type :password_reset_json
#     end
#   end

#   output :unauthorized do
#     status 401
#     type :object do
#       errors :object do
#         base :array do
#           type :string
#         end
#       end
#     end
#     description 'User is not authorized to access this endpoint.'
#   end

#   output :not_found do
#     status 404
#     type :object do
#       errors :object do
#         base :array do
#           type :string
#         end
#       end
#     end
#     description 'The record was not found.'
#   end

#   output :server_error do
#     status 500
#     type :object do
#       errors :object do
#         base :array do
#           type :string
#         end
#       end
#     end
#     description 'Internal Server Error. Server threw an unrecoverable error. Create a ticket with any form fields you we\'re trying to send, the URL, API version number and any steps you took so that it can be replicated.'
#   end
# end


FanlinkApi::API.endpoint :create_password_reset do
  description "This is used to initiate a password reset. Product and email or username required. If email or username is not found, password reset will fail silently."
  method :post
  tag "People"
  path "/password_resets"
  input do
    type :object do
      product(:string).explain do
        description "Internal name of product."
      end
      email_or_username(:string).explain do
        description "The person's email or username."
      end
    end
  end
  output :success do
    description "Reset password instructions have been sent to your email, if it exists in our system."
    status 200
    type :object do
      message :object do
        type :string
    end
  end

  output :server_error do
    status 500
    type :object do
      errors :object do
        base :array do
          type :string
        end
      end
    end
    description "Internal Server Error. Server threw an unrecoverable error. Create a ticket with any form fields you we're trying to send, the URL, API version number and any steps you took so that it can be replicated."
  end
end

FanlinkApi::API.endpoint :update_password_reset do
  method :put
  tag "People"
  path "/people/password_resets"
  input do
    type :object do
      token(:string).explain do
        description "Token from email link"
      end
      password(:string).explain do
        description "The new password."
      end
    end
  end
  output :success do
    status 200
    type :string
    description "HTTP/1.1 200 Ok"
  end

  output :unprocessible do
    status 422
    type :object do
      errors :object do
        base :array do
          type :string
        end
      end
    end
    description "One or more fields were invalid. Check response for reasons."
  end

  output :server_error do
    status 500
    type :object do
      errors :object do
        base :array do
          type :string
        end
      end
    end
    description "Internal Server Error. Server threw an unrecoverable error. Create a ticket with any form fields you we're trying to send, the URL, API version number and any steps you took so that it can be replicated."
  end
end

# FanlinkApi::API.endpoint :destroy_password_reset do
#   method :delete
#   tag 'People'
#   path '/password_resets/{id}' do
#     id :int32
#   end
#   output :success do
#     status 200
#     type :string
#   end

#   output :unauthorized do
#     status 401
#     type :object do
#       errors :object do
#         base :array do
#           type :string
#         end
#       end
#     end
#     description 'User is not authorized to access this endpoint.'
#   end

#   output :not_found do
#     status 404
#     type :object do
#       errors :object do
#         base :array do
#           type :string
#         end
#       end
#     end
#     description 'The record was not found.'
#   end

#   output :unprocessible do
#     status 422
#     type :object do
#       errors :object do
#         base :array do
#           type :string
#         end
#       end
#     end
#     description 'One or more fields were invalid. Check response for reasons.'
#   end

#   output :server_error do
#     status 500
#     type :object do
#       errors :object do
#         base :array do
#           type :string
#         end
#       end
#     end
#     description 'Internal Server Error. Server threw an unrecoverable error. Create a ticket with any form fields you we\'re trying to send, the URL, API version number and any steps you took so that it can be replicated.'
#   end
# end
