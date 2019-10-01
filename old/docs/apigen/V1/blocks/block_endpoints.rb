class AddBlockEndpoints < Apigen::Migration
  def up
    add_endpoint :create_block do
      description "This is used to block a person. When a person is blocked, any followings and relationships are immediately removed between the users."
      method :post
      tag "Block User"
      path "/blocks"
      input do
        type :object do
          block :object do
            blocker_id(:int32).explain do
              description "TODO: Description"
              example "TODO: Example"
            end
            blocked_id(:int32).explain do
              description "TODO: Description"
              example "TODO: Example"
            end
          end
        end
      end
      output :success do
        status 200
        type :object do
          block :block_response
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

    add_endpoint :destroy_block do
      method :delete
      tag "Block User"
      path "/blocks/{id}" do
        id :int32
      end
      output :success do
        status 200
        type :void
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


# FanlinkApi::API.endpoint :get_blocks do
#   method :get
#   tag 'Block User'
#   path '/blocks'
#   output :success do
#     status 200
#     type :object do
#       blocks :array do
#         type :block_response
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

# FanlinkApi::API.endpoint :get_a_block do
#   method :get
#   tag 'Block User'
#   path '/blocks/{id}' do
#     id :int32
#   end
#   output :success do
#     status 200
#     type :object do
#       type :block_response
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

# FanlinkApi::API.endpoint :update_block do
#   method :put
#   tag 'Block User'
#   path '/blocks/{id}' do
#     id :int32
#   end
#   input do
#     type :object do
#       block :object do
#         blocker_id(:int32).explain do
#           description 'TODO: Description'
#           example 'TODO: Example'
#         end
#         blocked_id(:int32).explain do
#           description 'TODO: Description'
#           example 'TODO: Example'
#         end
#       end
#     end
#   end
#   output :success do
#     status 200
#     type :object do
#       type :block_response
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
