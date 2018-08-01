FanlinkApi::API.endpoint :get_posts do
  description 
  method :get
  tag "Posts"
  path "/posts"
  output :success do
    status 200
    type :object do
      posts :array do
        type :post_json
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

FanlinkApi::API.endpoint :get_a_post do
  method :get
  tag "Posts"
  path "/posts/{id}" do
    id :int32
  end
  output :success do
    status 200
    type :object do
      type :post_json
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


FanlinkApi::API.endpoint :create_post do
  method :post
  tag "Posts"
  path "/posts"
  input do
    type :object do
      post :object do
        person_id(:int32).explain do
          description "TODO: Description"
          example "TODO: Example"
        end
        global(:bool).explain do
          description "TODO: Description"
          example "TODO: Example"
        end
        starts_at?(:string).explain do
          description "TODO: Description"
          example "TODO: Example"
        end
        ends_at?(:string).explain do
          description "TODO: Description"
          example "TODO: Example"
        end
        repost_interval(:int32).explain do
          description "TODO: Description"
          example "TODO: Example"
        end
        status(:int32).explain do
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
        body(:string).explain do
          description "TODO: Description"
          example "TODO: Example"
        end
        priority(:int32).explain do
          description "TODO: Description"
          example "TODO: Example"
        end
        recommended(:bool).explain do
          description "TODO: Description"
          example "TODO: Example"
        end
        notify_followers(:bool).explain do
          description "TODO: Description"
          example "TODO: Example"
        end
        audio_file_name?(:string).explain do
          description "TODO: Description"
          example "TODO: Example"
        end
        audio_content_type?(:string).explain do
          description "TODO: Description"
          example "TODO: Example"
        end
        audio_file_size?(:int32).explain do
          description "TODO: Description"
          example "TODO: Example"
        end
        audio_updated_at?(:string).explain do
          description "TODO: Description"
          example "TODO: Example"
        end
        category_id?(:int32).explain do
          description "TODO: Description"
          example "TODO: Example"
        end
      end
    end
  end
  output :success do
    status 200
    type :object do
      type :post_json
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

FanlinkApi::API.endpoint :update_post do
  method :put
  tag "Posts"
  path "/posts/{id}" do
    id :int32
  end
  input do
    type :object do
      post :object do
        person_id(:int32).explain do
          description "TODO: Description"
          example "TODO: Example"
        end
        global(:bool).explain do
          description "TODO: Description"
          example "TODO: Example"
        end
        starts_at?(:string).explain do
          description "TODO: Description"
          example "TODO: Example"
        end
        ends_at?(:string).explain do
          description "TODO: Description"
          example "TODO: Example"
        end
        repost_interval(:int32).explain do
          description "TODO: Description"
          example "TODO: Example"
        end
        status(:int32).explain do
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
        body(:string).explain do
          description "TODO: Description"
          example "TODO: Example"
        end
        priority(:int32).explain do
          description "TODO: Description"
          example "TODO: Example"
        end
        recommended(:bool).explain do
          description "TODO: Description"
          example "TODO: Example"
        end
        notify_followers(:bool).explain do
          description "TODO: Description"
          example "TODO: Example"
        end
        audio_file_name?(:string).explain do
          description "TODO: Description"
          example "TODO: Example"
        end
        audio_content_type?(:string).explain do
          description "TODO: Description"
          example "TODO: Example"
        end
        audio_file_size?(:int32).explain do
          description "TODO: Description"
          example "TODO: Example"
        end
        audio_updated_at?(:string).explain do
          description "TODO: Description"
          example "TODO: Example"
        end
        category_id?(:int32).explain do
          description "TODO: Description"
          example "TODO: Example"
        end
      end
    end
  end
  output :success do
    status 200
    type :object do
      type :post_json
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

FanlinkApi::API.endpoint :destroy_post do
  method :delete
  tag "Posts"
  path "/posts/{id}" do
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
