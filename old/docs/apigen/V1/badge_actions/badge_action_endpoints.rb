class AddBadgeActionEndpoints < Apigen::Migration
  def up
    add_endpoint :create_badge_action do
      method :post
      tag "Badge Actions"
      description "Create a badge action."
      path "/badge_actions"
      input do
        type :object do
          badge_action :object do
            action_type(:string).explain do
              description "The internal name of the action type to trigger."
              example "create_post"
            end
            identifier?(:string).explain do
              description "An identifier for the badge action."
              example "create_post_view"
            end
          end
        end
      end
      output :success do
        status 200
        type :oneof do
          discriminator :type
          map(
            pending_badge_response: "Pending Badge",
            badges_awarded_response: "Badges Awarded"
          )
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
        description "Internal Server Error. Server threw an unrecoverable error. Create a ticket with any form fields you were trying to send, the URL, API version number and any steps you took so that it can be replicated."
      end
    end
  end
end
