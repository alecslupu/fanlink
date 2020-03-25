class AddRelationshipEndpoints < Apigen::Migration
  def up
    add_endpoint :get_relationships do
      method :get
      tag "Relationships"
      path "/relationships"
      output :success do
        status 200
        type :object do
          relationships :array do
            type :relationship_response
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

    add_endpoint :get_a_relationship do
      method :get
      tag "Relationships"
      path "/relationships/{id}" do
        id :int32
      end
      output :success do
        status 200
        type :object do
          relationship :relationship_response
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

    add_endpoint :create_relationship do
      method :post
      tag "Relationships"
      path "/relationships"
      input do
        type :object do
          relationship :object do
            requested_by_id(:int32).explain do
              description "TODO: Description"
              example "TODO: Example"
            end
            requested_to_id(:int32).explain do
              description "TODO: Description"
              example "TODO: Example"
            end
            status(:int32).explain do
              description "TODO: Description"
              example "TODO: Example"
            end
          end
        end
      end
      output :success do
        status 200
        type :object do
          relationship :relationship_response
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

    add_endpoint :update_relationship do
      method :put
      tag "Relationships"
      path "/relationships/{id}" do
        id :int32
      end
      input do
        type :object do
          relationship :object do
            requested_by_id(:int32).explain do
              description "TODO: Description"
              example "TODO: Example"
            end
            requested_to_id(:int32).explain do
              description "TODO: Description"
              example "TODO: Example"
            end
            status(:int32).explain do
              description "TODO: Description"
              example "TODO: Example"
            end
          end
        end
      end
      output :success do
        status 200
        type :object do
          relationship :relationship_response
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

    add_endpoint :destroy_relationship do
      method :delete
      tag "Relationships"
      path "/relationships/{id}" do
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
