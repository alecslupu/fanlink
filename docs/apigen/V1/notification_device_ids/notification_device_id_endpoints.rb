FanlinkApi::API.endpoint :get_notification_device_ids do
  method :get
  tag notification_device_id
  path '/notification_device_ids'
  description 'Get Notification Device Ids'
  output :success do
    status 200
    type :object do
      notification_device_ids :array do
        type :oneof do
          discriminator :type
          map(
            notification_device_id_app_json: notification_device_id,
            notification_device_id_portal_json: notification_device_id
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
    description 'User is not authorized to access this endpoint.'
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
    description 'Internal Server Error. Server threw an unrecoverable error. Create a ticket with any form fields you were trying to send, the URL, API version number and any steps you took so that it can be replicated.'
  end
end

FanlinkApi::API.endpoint :get_a_notification_device_id do
  method :get
  tag notification_device_id
  path '/notification_device_ids/{id}' do
    id :int32
  end
  description 'Get a Notification Device Id'
  output :success do
    status 200
    type :object do
      type :oneof do
        discriminator :type
        map(
          notification_device_id_app_json: notification_device_id,
          notification_device_id_portal_json: notification_device_id
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
    description 'User is not authorized to access this endpoint.'
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
    description 'The record was not found.'
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
    description 'Internal Server Error. Server threw an unrecoverable error. Create a ticket with any form fields you we\'re trying to send, the URL, API version number and any steps you took so that it can be replicated.'
  end
end


FanlinkApi::API.endpoint :create_a_notification_device_id do
  method :post
  tag notification_device_id
  path '/notification_device_ids'
  description 'Create a Notification Device Id'
  input do
    type :object do
      notification_device_id :object do
        person_id(:int32).explain do
          description ''
          example ''
        end
        device_identifier(:string).explain do
          description ''
          example ''
        end
      end
    end
  end
  output :success do
    status 200
    type :object do
      type :notification_device_id_app_json
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
    description 'User is not authorized to access this endpoint.'
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
    description 'The record was not found.'
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
    description 'One or more fields were invalid. Check response for reasons.'
  end

  output :rate_limit do
    status 429
    type :string
    description 'Not enough time since last submission of this action type or duplicate action type, person, identifier combination.'
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
    description 'Internal Server Error. Server threw an unrecoverable error. Create a ticket with any form fields you we\'re trying to send, the URL, API version number and any steps you took so that it can be replicated.'
  end
end

FanlinkApi::API.endpoint :update_a_notification_device_id do
  method :put
  tag notification_device_id
  path '/notification_device_ids/{id}' do
    id :int32
  end
  description 'Update a Notification Device Id'
  input do
    type :object do
      notification_device_id :object do
        person_id(:int32).explain do
          description ''
          example ''
        end
        device_identifier(:string).explain do
          description ''
          example ''
        end
      end
    end
  end
  output :success do
    status 200
    type :object do
      type :notification_device_id_app_json
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
    description 'User is not authorized to access this endpoint.'
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
    description 'The record was not found.'
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
    description 'One or more fields were invalid. Check response for reasons.'
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
    description 'Internal Server Error. Server threw an unrecoverable error. Create a ticket with any form fields you we\'re trying to send, the URL, API version number and any steps you took so that it can be replicated.'
  end
end

FanlinkApi::API.endpoint :destroy_a_notification_device_id do
  method :delete
  tag notification_device_id
  path '/notification_device_ids/{id}' do
    id :int32
  end
  description 'Destroy a Notification Device Id'
  output :success do
    status 200
    type :string
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
    description 'User is not authorized to access this endpoint.'
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
    description 'The record was not found.'
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
    description 'One or more fields were invalid. Check response for reasons.'
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
    description 'Internal Server Error. Server threw an unrecoverable error. Create a ticket with any form fields you we\'re trying to send, the URL, API version number and any steps you took so that it can be replicated.'
  end
end
