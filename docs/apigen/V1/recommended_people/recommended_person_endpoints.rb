FanlinkApi::API.endpoint :get_recommended_people do
  method :get
  tag 'Recommended People'
  path '/recommended_people'
  output :success do
    status 200
    type :object do
      recommended_people :array do
        type :recommended_person_json
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
    description 'Internal Server Error. Server threw an unrecoverable error. Create a ticket with any form fields you we\'re trying to send, the URL, API version number and any steps you took so that it can be replicated.'
  end
end

FanlinkApi::API.endpoint :get_a_recommended_person do
  method :get
  tag 'Recommended People'
  path '/recommended_people/{id}' do
    id :int32
  end
  output :success do
    status 200
    type :object do
      type :recommended_person_json
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


FanlinkApi::API.endpoint :create_recommended_person do
  method :post
  tag 'Recommended People'
  path '/recommended_people'
  input do
    type :object do
      recommended_person :object do
        person :string
      end
    end
  end
  output :success do
    status 200
    type :object do
      type :recommended_person_json
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

FanlinkApi::API.endpoint :update_recommended_person do
  method :put
  tag 'Recommended People'
  path '/recommended_people/{id}' do
    id :int32
  end
  input do
    type :object do
      recommended_person :object do
        person :string
      end
    end
  end
  output :success do
    status 200
    type :object do
      type :recommended_person_json
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

FanlinkApi::API.endpoint :destroy_recommended_person do
  method :delete
  tag 'Recommended People'
  path '/recommended_people/{id}' do
    id :int32
  end
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
