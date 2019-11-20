class AddRoomMembershipEndpoints < Apigen::Migration
  def up
    add_endpoint :create_room_membership do
      method :post
      tag "Room Memberships"
      path "/room_memberships"
      input do
        type :object do
          room_membership :object do
            room_id(:int32).explain do
              description "TODO: Description"
              example "TODO: Example"
            end
            person_id(:int32).explain do
              description "TODO: Description"
              example "TODO: Example"
            end
            message_count(:int32).explain do
              description "TODO: Description"
              example "TODO: Example"
            end
          end
        end
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
  end
end
