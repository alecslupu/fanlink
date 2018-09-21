class AddFollowingEndpoints < Apigen::Migration
    def up
      add_endpoint :get_followings do
        description "This is used to get a list of someone's followers or followed. If followed_id parameter is supplied, it will get the follower's of that user. If follower_id is supplied, it will get the people that person is following. If nothing is supplied it will get the people the current user is following."
        method :get
        tag "Followings"
        path "/followings"
        query do
          followed_id?(:int32).explain do
            description "ID of the person who's followers to get."
            example 1
          end
          follower_id?(:int32).explain do
            description "Id of person who is following the people in the list we are getting."
            example 2
          end
        end
        output :success do
          status 200
          type :object do
            followings :array do
              type :following_response
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

      add_endpoint :create_following do
        description "This is used to follow a person."
        method :post
        tag "Follwoings"
        path "/followings"
        input do
          type :object do
            followed_id(:int32).explain do
              description "Person to follow."
              example 2
            end
          end
        end
        output :success do
          status 200
          type :object do
            following :following_response
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

      add_endpoint :destroy_following do
        description "This is used to unfollow a person."
        method :delete
        tag "Follow a user"
        path "/followings/{id}" do
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

# FanlinkApi::API.endpoint :get_a_following do
#   method :get
#   tag 'Follow a user'
#   path '/followings/{id}' do
#     id :int32
#   end
#   output :success do
#     status 200
#     type :object do
#       type :following_response
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

# FanlinkApi::API.endpoint :update_following do
#   method :put
#   tag 'Follow a user'
#   path '/followings/{id}' do
#     id :int32
#   end
#   input do
#     type :object do
#       following :object do
#         follower_id(:int32).explain do
#           description 'TODO: Description'
#           example 'TODO: Example'
#         end
#         followed_id(:int32).explain do
#           description 'TODO: Description'
#           example 'TODO: Example'
#         end
#       end
#     end
#   end
#   output :success do
#     status 200
#     type :object do
#       type :following_response
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
