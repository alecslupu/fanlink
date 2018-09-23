class AddBadgeEndpoints < Apigen::Migration
  def up
    add_endpoint :get_badges do
      description "This gets a list of all badges earned for a passed in user. Will include points earned towards each badge and whether badge has been awarded to the user."
      method :get
      tag "Badges"
      path "/badges"
      query do
        person_id(:int32).explain do
          description "The id of the person whose badges you want."
          example 1
        end
      end
      output :success do
        status 200
        type :object do
          badges :array do
            type :badge_response
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

# FanlinkApi::API.endpoint :get_a_badge do
#   method :get
#   tag 'Badges'
#   path '/badges/{id}' do
#     id :int32
#   end
#   output :success do
#     status 200
#     type :object do
#       type :badge_response
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
#     description 'Internal Server Error. Server threw an unrecoverable error. Create a ticket with any form fields you were trying to send, the URL, API version number and any steps you took so that it can be replicated.'
#   end
# end

# FanlinkApi::API.endpoint :update_badge do
#   method :put
#   tag 'Badges'
#   description 'Updates a badge'
#   path '/badges/{id}' do
#     id :int32
#   end
#   input do
#     type :object do
#       badge :object do
#         product_id(:int32).explain do
#           description 'TODO: Description'
#           example 'TODO: Example'
#         end
#         internal_name(:string).explain do
#           description 'TODO: Description'
#           example 'TODO: Example'
#         end
#         action_type_id?(:int32).explain do
#           description 'TODO: Description'
#           example 'TODO: Example'
#         end
#         action_requirement(:int32).explain do
#           description 'TODO: Description'
#           example 'TODO: Example'
#         end
#         point_value(:int32).explain do
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
#         name(:string).explain do
#           description 'TODO: Description'
#           example 'TODO: Example'
#         end
#         description(:string).explain do
#           description 'TODO: Description'
#           example 'TODO: Example'
#         end
#         issued_from?(:string).explain do
#           description 'TODO: Description'
#           example 'TODO: Example'
#         end
#         issued_to?(:string).explain do
#           description 'TODO: Description'
#           example 'TODO: Example'
#         end
#       end
#     end
#   end
#   output :success do
#     status 200
#     type :object do
#       type :badge_response
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
#     description "One or more fields were invalid. Check response for reasons."
#     type :object do
#       errors :object do
#         base :array do
#           type :string
#         end
#       end
#     end
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
#     description 'Internal Server Error. Server threw an unrecoverable error. Create a ticket with any form fields you were trying to send, the URL, API version number and any steps you took so that it can be replicated.'
#   end
# end

# FanlinkApi::API.endpoint :destroy_badge do
#   method :delete
#   tag 'Badges'
#   path '/badges/{id}' do
#     id :string
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
#     description 'Internal Server Error. Server threw an unrecoverable error. Create a ticket with any form fields you were trying to send, the URL, API version number and any steps you took so that it can be replicated.'
#   end
# end
