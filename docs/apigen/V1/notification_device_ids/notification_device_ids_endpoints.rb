class AddNotificationDeviceIdEndpoints < Apigen::Migration
  def up
    add_endpoint :create_a_notification_device_id do
      description "This adds a new device id to be used for notifications to the Firebase Cloud Messaging Service. A user can have any number of device ids."
      method :post
      tag "Notification Device IDs"
      path "/notification_device_ids"
      description "Create a Notification Device Id"
      input do
        type :object do
          device_id(:string).explain do
            description "ID of the device"
            #example ""
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

    add_endpoint :destroy_a_notification_device_id do
      method :delete
      tag "Notification Device IDs"
      path "/notification_device_ids/{id}" do
        id :int32
      end
      description "Destroy a Notification Device Id"
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