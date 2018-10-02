class AddRoomEndpoints < Apigen::Migration
  def up
    add_endpoint :get_rooms do
      method :get
      tag "Rooms"
      path "/rooms"
      output :success do
        status 200
        type :object do
          rooms :array do
            type :oneof do
              discriminator :type
              map(
                room_response: "Room App Response",
                room_portal_response: "Room Portal Response"
              )
            end
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

    add_endpoint :get_a_room do
      method :get
      tag "Rooms"
      path "/rooms/{id}" do
        id :int32
      end
      output :success do
        status 200
        type :object do
          room :oneof do
            discriminator :type
            map(
              room_response: "Room App Response",
              room_portal_response: "Room Portal Response"
            )
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

    add_endpoint :create_room do
      method :post
      tag "Rooms"
      path "/rooms"
      input do
        type :object do
          room :object do
            product_id(:int32).explain do
              description "TODO: Description"
              example "TODO: Example"
            end
            created_by_id?(:int32).explain do
              description "TODO: Description"
              example "TODO: Example"
            end
            status(:int32).explain do
              description "TODO: Description"
              example "TODO: Example"
            end
            public(:bool).explain do
              description "TODO: Description"
              example "TODO: Example"
            end
            picture_file_name?(:string).explain do
              description "TODO: Description"
              example "TODO: Example"
            end
            picture_content_type?(:string).explain do
              description "TODO: Description"
              example "TODO: Example"
            end
            picture_file_size?(:int32).explain do
              description "TODO: Description"
              example "TODO: Example"
            end
            picture_updated_at?(:string).explain do
              description "TODO: Description"
              example "TODO: Example"
            end
            name(:string).explain do
              description "TODO: Description"
              example "TODO: Example"
            end
            description(:string).explain do
              description "TODO: Description"
              example "TODO: Example"
            end
          end
        end
      end
      output :success do
        status 200
        type :object do
          room :oneof do
            discriminator :type
            map(
              room_response: "Room App Response",
              room_portal_response: "Room Portal Response"
            )
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

    add_endpoint :update_room do
      method :put
      tag "Rooms"
      path "/rooms/{id}" do
        id :int32
      end
      input do
        type :object do
          room :object do
            product_id(:int32).explain do
              description "TODO: Description"
              example "TODO: Example"
            end
            created_by_id?(:int32).explain do
              description "TODO: Description"
              example "TODO: Example"
            end
            status(:int32).explain do
              description "TODO: Description"
              example "TODO: Example"
            end
            public(:bool).explain do
              description "TODO: Description"
              example "TODO: Example"
            end
            picture_file_name?(:string).explain do
              description "TODO: Description"
              example "TODO: Example"
            end
            picture_content_type?(:string).explain do
              description "TODO: Description"
              example "TODO: Example"
            end
            picture_file_size?(:int32).explain do
              description "TODO: Description"
              example "TODO: Example"
            end
            picture_updated_at?(:string).explain do
              description "TODO: Description"
              example "TODO: Example"
            end
            name(:string).explain do
              description "TODO: Description"
              example "TODO: Example"
            end
            description(:string).explain do
              description "TODO: Description"
              example "TODO: Example"
            end
          end
        end
      end
      output :success do
        status 200
        type :object do
          room :oneof do
            discriminator :type
            map(
              room_response: "Room App Response",
              room_portal_response: "Room Portal Response"
            )
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

    add_endpoint :destroy_room do
      method :delete
      tag "Rooms"
      path "/rooms/{id}" do
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
