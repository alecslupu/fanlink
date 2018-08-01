FanlinkApi::API.endpoint :get_recommended_posts do
  method :get
  tag "Recommended Posts"
  path "/recommended_posts"
  output :success do
    status 200
    type :object do
      recommended_posts :array do
        type :recommended_post_json
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

FanlinkApi::API.endpoint :get_a_recommended_post do
  method :get
  tag "Recommended Posts"
  path "/recommended_posts/{id}" do
    id :int32
  end
  output :success do
    status 200
    type :object do
      type :recommended_post_json
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


FanlinkApi::API.endpoint :create_recommended_post do
  method :post
  tag "Recommended Posts"
  path "/recommended_posts"
  input do
    type :object do
      recommended_post :object do
        post :string
      end
    end
  end
  output :success do
    status 200
    type :object do
      type :recommended_post_json
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

FanlinkApi::API.endpoint :update_recommended_post do
  method :put
  tag "Recommended Posts"
  path "/recommended_posts/{id}" do
    id :int32
  end
  input do
    type :object do
      recommended_post :object do
        post :string
      end
    end
  end
  output :success do
    status 200
    type :object do
      type :recommended_post_json
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

FanlinkApi::API.endpoint :destroy_recommended_post do
  method :delete
  tag "Recommended Posts"
  path "/recommended_posts/{id}" do
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
