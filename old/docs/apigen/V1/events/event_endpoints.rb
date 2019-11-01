class AddEventEndpoints < Apigen::Migration
    def up
      add_endpoint :get_events do
        description "Returns all events associated with the current user's product."
        method :get
        tag "Events"
        path "/events"
        output :success do
          status 200
          type :object do
            events :array do
              type :event_response
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

      add_endpoint :get_an_event do
        description "Returns a single event."
        method :get
        tag "Events"
        path "/events/{id}" do
          id :int32
        end
        output :success do
          status 200
          type :object do
            event :event_response
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

# FanlinkApi::API.endpoint :create_an_event do
#   method :post
#   tag 'Events'
#   path '/events'
#   input do
#     type :object do
#       event :object do
#         product_id(:int32).explain do
#           description 'TODO: Description'
#           example 'TODO: Example'
#         end
#         name(:string).explain do
#           description 'TODO: Description'
#           example 'TODO: Example'
#         end
#         description?(:string).explain do
#           description 'TODO: Description'
#           example 'TODO: Example'
#         end
#         starts_at(:string).explain do
#           description 'TODO: Description'
#           example 'TODO: Example'
#         end
#         ends_at?(:string).explain do
#           description 'TODO: Description'
#           example 'TODO: Example'
#         end
#         ticket_url?(:string).explain do
#           description 'TODO: Description'
#           example 'TODO: Example'
#         end
#         place_identifier?(:string).explain do
#           description 'TODO: Description'
#           example 'TODO: Example'
#         end
#         deleted(:bool).explain do
#           description 'TODO: Description'
#           example 'TODO: Example'
#         end
#       end
#     end
#   end
#   output :success do
#     status 200
#     type :object do
#       type :event_response
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

#   output :rate_limit do
#     status 429
#     type :string
#     description 'Not enough time since last submission of this action type or duplicate action type, person, identifier combination.'
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

# FanlinkApi::API.endpoint :update_an_event do
#   method :put
#   tag 'Events'
#   path '/events/{id}' do
#     id :int32
#   end
#   input do
#     type :object do
#       event :object do
#         product_id(:int32).explain do
#           description 'TODO: Description'
#           example 'TODO: Example'
#         end
#         name(:string).explain do
#           description 'TODO: Description'
#           example 'TODO: Example'
#         end
#         description?(:string).explain do
#           description 'TODO: Description'
#           example 'TODO: Example'
#         end
#         starts_at(:string).explain do
#           description 'TODO: Description'
#           example 'TODO: Example'
#         end
#         ends_at?(:string).explain do
#           description 'TODO: Description'
#           example 'TODO: Example'
#         end
#         ticket_url?(:string).explain do
#           description 'TODO: Description'
#           example 'TODO: Example'
#         end
#         place_identifier?(:string).explain do
#           description 'TODO: Description'
#           example 'TODO: Example'
#         end
#         deleted(:bool).explain do
#           description 'TODO: Description'
#           example 'TODO: Example'
#         end
#       end
#     end
#   end
#   output :success do
#     status 200
#     type :object do
#       type :event_response
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

# FanlinkApi::API.endpoint :destroy_an_event do
#   method :delete
#   tag 'Events'
#   path '/events/{id}' do
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
