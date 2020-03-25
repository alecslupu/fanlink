class AddLevelEndpoints < Apigen::Migration
    def up
      add_endpoint :get_levels do
        description "This gets a list of all levels available to be obtained."
        method :get
        tag "User level"
        path "/levels"
        output :success do
          status 200
          type :object do
            levels :array do
              type :level_response
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
          description "Internal Server Error. Server threw an unrecoverable error. Create a ticket with any form fields you were trying to send, the URL, API version number and any steps you took so that it can be replicated."
        end
      end
    end
  end

# FanlinkApi::API.endpoint :get_a_level do
#   method :get
#   tag 'User level'
#   path '/levels/{id}' do
#     id :int32
#   end
#   output :success do
#     status 200
#     type :object do
#       type :level_response
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


# FanlinkApi::API.endpoint :create_level do
#   method :post
#   tag 'User level'
#   path '/levels'
#   input do
#     type :object do
#       level :object do
#         product_id(:int32).explain do
#           description ''
#           example ''
#         end
#         internal_name(:string).explain do
#           description ''
#           example ''
#         end
#         points(:int32).explain do
#           description ''
#           example ''
#         end
#         picture_file_name?(:string).explain do
#           description ''
#           example ''
#         end
#         picture_content_type?(:string).explain do
#           description ''
#           example ''
#         end
#         picture_file_size?(:int32).explain do
#           description ''
#           example ''
#         end
#         picture_updated_at?(:string).explain do
#           description ''
#           example ''
#         end
#         description(:string).explain do
#           description ''
#           example ''
#         end
#         name(:string).explain do
#           description ''
#           example ''
#         end
#       end
#     end
#   end
#   output :success do
#     status 200
#     type :object do
#       type :level_response
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

# FanlinkApi::API.endpoint :update_level do
#   method :put
#   tag 'User level'
#   path '/levels/{id}' do
#     id :int32
#   end
#   input do
#     type :object do
#       level :object do
#         product_id(:int32).explain do
#           description ''
#           example ''
#         end
#         internal_name(:string).explain do
#           description ''
#           example ''
#         end
#         points(:int32).explain do
#           description ''
#           example ''
#         end
#         picture_file_name?(:string).explain do
#           description ''
#           example ''
#         end
#         picture_content_type?(:string).explain do
#           description ''
#           example ''
#         end
#         picture_file_size?(:int32).explain do
#           description ''
#           example ''
#         end
#         picture_updated_at?(:string).explain do
#           description ''
#           example ''
#         end
#         description(:string).explain do
#           description ''
#           example ''
#         end
#         name(:string).explain do
#           description ''
#           example ''
#         end
#       end
#     end
#   end
#   output :success do
#     status 200
#     type :object do
#       type :level_response
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

# FanlinkApi::API.endpoint :destroy_level do
#   method :delete
#   tag 'User level'
#   path '/levels/{id}' do
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
