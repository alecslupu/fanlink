FanlinkApi::API.endpoint :get_post_comment_reports do
  method :get
  tag 'Post Comment Reports'
  path '/post_comment_reports'
  output :success do
    status 200
    type :object do
      post_comment_reports :array do
        type :post_comment_report_json
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

FanlinkApi::API.endpoint :get_a_post_comment_report do
  method :get
  tag 'Post Comment Reports'
  path '/post_comment_reports/{id}' do
    id :int32
  end
  output :success do
    status 200
    type :object do
      type :post_comment_report_json
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


FanlinkApi::API.endpoint :create_a_post_comment_report do
  method :post
  tag 'Post Comment Reports'
  path '/post_comment_reports'
  input do
    type :object do
      post_comment_report :object do
        post_comment_id(:int32).explain do
          description 'TODO: Description'
          example 'TODO: Example'
        end
        person_id(:int32).explain do
          description 'TODO: Description'
          example 'TODO: Example'
        end
        reason?(:string).explain do
          description 'TODO: Description'
          example 'TODO: Example'
        end
        status(:int32).explain do
          description 'TODO: Description'
          example 'TODO: Example'
        end
      end
    end
  end
  output :success do
    status 200
    type :object do
      type :post_comment_report_json
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

FanlinkApi::API.endpoint :update_a_post_comment_report do
  method :put
  tag 'Post Comment Reports'
  tag 'Post Comment Reports'
  path '/post_comment_reports/{id}' do
    id :int32
  end
  input do
    type :object do
      post_comment_report :object do
        post_comment_id(:int32).explain do
          description 'TODO: Description'
          example 'TODO: Example'
        end
        person_id(:int32).explain do
          description 'TODO: Description'
          example 'TODO: Example'
        end
        reason?(:string).explain do
          description 'TODO: Description'
          example 'TODO: Example'
        end
        status(:int32).explain do
          description 'TODO: Description'
          example 'TODO: Example'
        end
      end
    end
  end
  output :success do
    status 200
    type :object do
      type :post_comment_report_json
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

FanlinkApi::API.endpoint :destroy_a_post_comment_report do
  method :delete
  tag 'Post Comment Reports'
  path '/post_comment_reports/{id}' do
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
