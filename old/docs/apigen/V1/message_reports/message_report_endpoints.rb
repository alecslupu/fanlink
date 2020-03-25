class AddMessageReportEndpoints < Apigen::Migration
  def up
    add_endpoint :get_message_reports do
      description "Get list of messages reports (ADMIN)."
      method :get
      tag "Message Reports"
      path "/message_reports"
      query do
        status_filter(:string).explain do
          description "If provided, valid values are 'message_hidden', 'no_action_needed', and 'pending'"
        end
      end
      output :success do
        status 200
        type :object do
          message_reports :array do
            type :message_report_response
          end
        end
      end
    
      output :unauthorized do
        status 401
        type :object do
          errors :object do
            base :array do
              type :string
            end
          end
        end
        description "User is not authorized to access this endpoint."
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

    add_endpoint :create_message_report do
      description "This reports a message that was posted to a public room."
      method :post
      tag "Message Reports"
      path "/room/{room_id}/message_reports" do
        room_id :int32
      end
      input do
        type :object do
          message_report :object do
            message_id(:int32).explain do
              description "The id of the message being reported."
              example 1
            end
            reason?(:string).explain do
              description "The reason given by the user for reporting the message."
              example "Harrassment"
            end
          end
        end
      end
      output :success do
        status 200
        type :object do
          message_report :message_report_response
        end
      end
      output :unauthorized do
        status 401
        type :object do
          errors :object do
            base :array do
              type :string
            end
          end
        end
        description "User is not authorized to access this endpoint."
      end
      output :not_found do
        status 404
        type :object do
          errors :object do
            base :array do
              type :string
            end
          end
        end
        description "The record was not found."
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
      output :rate_limit do
        status 429
        type :string
        description "Not enough time since last submission of this action type or duplicate action type, person, identifier combination."
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

    add_endpoint :update_message_report do
      description "This updates a message report. The only value that can be changed is the status."
      method :put
      tag "Message Reports"
      path "/message_reports/{id}" do
        id :int32
      end
      input do
        type :object do
          message_report :object do
            status(:int32).explain do
              description "The new status. Valid statuses are 'message_hidden', 'no_action_needed', and 'pending'."
              example "no_action_needed"
            end
          end
        end
      end
      output :success do
        status 200
        type :object do
          message_report :message_report_response
        end
      end
    
      output :unauthorized do
        status 401
        type :object do
          errors :object do
            base :array do
              type :string
            end
          end
        end
        description "User is not authorized to access this endpoint."
      end
    
      output :not_found do
        status 404
        type :object do
          errors :object do
            base :array do
              type :string
            end
          end
        end
        description "The record was not found."
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
  end
end
# FanlinkApi::API.endpoint :get_a_message_report do
#   method :get
#   tag 'Message Reports'
#   path '/message_reports/{id}' do
#     id :int32
#   end
#   output :success do
#     status 200
#     type :object do
#       type :message_report_response
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

# FanlinkApi::API.endpoint :destroy_message_report do
#   method :delete
#   tag 'Message Reports'
#   path '/message_reports/{id}' do
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
