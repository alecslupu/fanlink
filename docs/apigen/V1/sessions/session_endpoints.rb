FanlinkApi::API.endpoint :get_sessions do
  method :get
  tag "Sessions"
  path "/sessions"
  output :success do
    status 200
    type :object do
      sessions :array do
        type :session_json
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

FanlinkApi::API.endpoint :get_a_session do
  method :get
  tag "Sessions"
  path "/sessions/{id}" do
    id :int32
  end
  output :success do
    status 200
    type :object do
      type :session_json
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


FanlinkApi::API.endpoint :create_session do
  method :post
  tag "Sessions"
  path "/sessions"
  input do
    type :object do
      session :object do
        email_or_username :string
        password :string
      end
    end
  end
  output :success do
    status 200
    type :object do
      type :session_json
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

FanlinkApi::API.endpoint :update_session do
  method :put
  tag "Sessions"
  path "/sessions/{id}" do
    id :int32
  end
  input do
    type :object do
      session :object do
        email_or_username :string
        password :string
      end
    end
  end
  output :success do
    status 200
    type :object do
      type :session_json
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

FanlinkApi::API.endpoint :destroy_session do
  method :delete
  tag "Sessions"
  path "/sessions/{id}" do
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
