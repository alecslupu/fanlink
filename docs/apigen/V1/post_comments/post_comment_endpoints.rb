FanlinkApi::API.endpoint :get_post_comments do
  method :get
  tag 'Post Comments'
  path '/post_comments'
  output :success do
    status 200
    type :object do
      post_comments :array do
        type :post_comment_json
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

FanlinkApi::API.endpoint :get_a_post_comment do
  method :get
  tag 'Post Comments'
  path '/post_comments/{id}' do
    id :int32
  end
  output :success do
    status 200
    type :object do
      type :post_comment_json
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


FanlinkApi::API.endpoint :create_post_comment do
  method :post
  tag 'Post Comments'
  path '/post_comments'
  input do
    type :object do
      post_comment :object do
        post_id(:int32).explain do
          description 'TODO: Description'
          example 'TODO: Example'
        end
        person_id(:int32).explain do
          description 'TODO: Description'
          example 'TODO: Example'
        end
        body(:string).explain do
          description 'TODO: Description'
          example 'TODO: Example'
        end
        hidden(:bool).explain do
          description 'TODO: Description'
          example 'TODO: Example'
        end
      end
    end
  end
  output :success do
    status 200
    type :object do
      type :post_comment_json
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

FanlinkApi::API.endpoint :update_post_comment do
  method :put
  tag 'Post Comments'
  path '/post_comments/{id}' do
    id :int32
  end
  input do
    type :object do
      post_comment :object do
        post_id(:int32).explain do
          description 'TODO: Description'
          example 'TODO: Example'
        end
        person_id(:int32).explain do
          description 'TODO: Description'
          example 'TODO: Example'
        end
        body(:string).explain do
          description 'TODO: Description'
          example 'TODO: Example'
        end
        hidden(:bool).explain do
          description 'TODO: Description'
          example 'TODO: Example'
        end
      end
    end
  end
  output :success do
    status 200
    type :object do
      type :post_comment_json
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

FanlinkApi::API.endpoint :destroy_post_comment do
  method :delete
  tag 'Post Comments'
  path '/post_comments/{id}' do
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
