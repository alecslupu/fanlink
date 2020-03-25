class Addactivity_typeEndpoints < Apigen::Migration
  def up
    add_endpoint :get_activity_types do
      method :get
      tag activity_type
      path "/activity_types"
      description "Get Activity Types"
      output :success do
        status 200
        type :object do
          activity_types :array do
            type :activity_type_response
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

    add_endpoint :get_a_activity_type do
      method :get
      tag activity_type
      path "/activity_types/{id}" do
        id :int32
      end
      description "Get a Activity Type"
      output :success do
        status 200
        type :object do
          activity_type :activity_type_response
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

    add_endpoint :create_a_activity_type do
      method :post
      tag activity_type
      path "/activity_types"
      description "Create a Activity Type"
      input do
        type :object do
          activity_type :object do
            activity_id(:int32).explain do
              description ""
              example ""
            end
            value(:string).explain do
              description ""
              example ""
            end
            deleted(:boolean).explain do
              description ""
              example ""
            end
            atype(:int32).explain do
              description ""
              example ""
            end
          end
        end
      end
      output :success do
        status 200
        type :object do
          activity_type :activity_type_response
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

    add_endpoint :update_a_activity_type do
      method :put
      tag activity_type
      path "/activity_types/{id}" do
        id :int32
      end
      description "Update a Activity Type"
      input do
        type :object do
          activity_type :object do
            activity_id(:int32).explain do
              description ""
              example ""
            end
            value(:string).explain do
              description ""
              example ""
            end
            deleted(:bool).explain do
              description ""
              example ""
            end
            atype(:int32).explain do
              description ""
              example ""
            end
          end
        end
      end
      output :success do
        status 200
        type :object do
          activity_type :activity_type_response
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

    add_endpoint :destroy_a_activity_type do
      method :delete
      tag activity_type
      path "/activity_types/{id}" do
        id :int32
      end
      description "Destroy a Activity Type"
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