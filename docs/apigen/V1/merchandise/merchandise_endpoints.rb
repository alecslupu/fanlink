class AddMerchandiseEndpoints < Apigen::Migration
  def up
    add_endpoint :get_merchandise do
      description "This gets a list of merchandise, in priority order."
      method :get
      tag "Merchandise"
      path "/merchandise"
      query do
        page?(:int32).explain do
          description "page, greater than 1"
          example 1
        end
        per_page?(:int32).explain do
          description "How many records to return per page."
          example 25
        end
      end
      output :success do
        status 200
        type :object do
          merchandise :array do
            type :merchandise_response
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

    add_endpoint :get_a_merchandise do
      method :get
      tag "Merchandise"
      path "/merchandise/{id}" do
        id :int32
      end
      output :success do
        status 200
        type :object do
          merchandise :merchandise_response
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

# FanlinkApi::API.endpoint :create_merchandise do
#   method :post
#   tag 'Merchandise'
#   path '/merchandise'
#   input do
#     type :object do
#       merchandise :object do
#         product_id(:int32).explain do
#           description 'TODO: Description'
#           example 'TODO: Example'
#         end
#         price?(:string).explain do
#           description 'TODO: Description'
#           example 'TODO: Example'
#         end
#         purchase_url?(:string).explain do
#           description 'TODO: Description'
#           example 'TODO: Example'
#         end
#         picture_file_name?(:string).explain do
#           description 'TODO: Description'
#           example 'TODO: Example'
#         end
#         picture_content_type?(:string).explain do
#           description 'TODO: Description'
#           example 'TODO: Example'
#         end
#         picture_file_size?(:int32).explain do
#           description 'TODO: Description'
#           example 'TODO: Example'
#         end
#         picture_updated_at?(:string).explain do
#           description 'TODO: Description'
#           example 'TODO: Example'
#         end
#         available(:bool).explain do
#           description 'TODO: Description'
#           example 'TODO: Example'
#         end
#         name(:string).explain do
#           description 'TODO: Description'
#           example 'TODO: Example'
#         end
#         description(:string).explain do
#           description 'TODO: Description'
#           example 'TODO: Example'
#         end
#         priority(:int32).explain do
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
#       type :merchandise_response
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

# FanlinkApi::API.endpoint :update_merchandise do
#   method :put
#   tag 'Merchandise'
#   path '/merchandise/{id}' do
#     id :int32
#   end
#   input do
#     type :object do
#       merchandise :object do
#         product_id(:int32).explain do
#           description 'TODO: Description'
#           example 'TODO: Example'
#         end
#         price?(:string).explain do
#           description 'TODO: Description'
#           example 'TODO: Example'
#         end
#         purchase_url?(:string).explain do
#           description 'TODO: Description'
#           example 'TODO: Example'
#         end
#         picture_file_name?(:string).explain do
#           description 'TODO: Description'
#           example 'TODO: Example'
#         end
#         picture_content_type?(:string).explain do
#           description 'TODO: Description'
#           example 'TODO: Example'
#         end
#         picture_file_size?(:int32).explain do
#           description 'TODO: Description'
#           example 'TODO: Example'
#         end
#         picture_updated_at?(:string).explain do
#           description 'TODO: Description'
#           example 'TODO: Example'
#         end
#         available(:bool).explain do
#           description 'TODO: Description'
#           example 'TODO: Example'
#         end
#         name(:string).explain do
#           description 'TODO: Description'
#           example 'TODO: Example'
#         end
#         description(:string).explain do
#           description 'TODO: Description'
#           example 'TODO: Example'
#         end
#         priority(:int32).explain do
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
#       type :merchandise_response
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

# FanlinkApi::API.endpoint :destroy_merchandise do
#   method :delete
#   tag 'Merchandise'
#   path '/merchandise/{id}' do
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
