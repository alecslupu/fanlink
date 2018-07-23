FanlinkApi::API.endpoint :get_people do
  method :get
  tag 'People'
  path '/people'
  output :success do
    status 200
    type :object do
      people :array do
        type :person_json
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

FanlinkApi::API.endpoint :get_a_person do
  method :get
  tag 'People'
  path '/people/{id}' do
    id :int32
  end
  output :success do
    status 200
    type :object do
      type :person_json
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


FanlinkApi::API.endpoint :create_person do
  method :post
  tag 'People'
  path '/people'
  input do
    type :object do
      person :object do
        username(:string).explain do
          description 'TODO: Description'
          example 'TODO: Example'
        end
        username_canonical(:string).explain do
          description 'TODO: Description'
          example 'TODO: Example'
        end
        email?(:string).explain do
          description 'TODO: Description'
          example 'TODO: Example'
        end
        name?(:string).explain do
          description 'TODO: Description'
          example 'TODO: Example'
        end
        product_id(:int32).explain do
          description 'TODO: Description'
          example 'TODO: Example'
        end
        crypted_password?(:string).explain do
          description 'TODO: Description'
          example 'TODO: Example'
        end
        salt?(:string).explain do
          description 'TODO: Description'
          example 'TODO: Example'
        end
        facebookid?(:string).explain do
          description 'TODO: Description'
          example 'TODO: Example'
        end
        facebook_picture_url?(:string).explain do
          description 'TODO: Description'
          example 'TODO: Example'
        end
        picture_file_name?(:string).explain do
          description 'TODO: Description'
          example 'TODO: Example'
        end
        picture_content_type?(:string).explain do
          description 'TODO: Description'
          example 'TODO: Example'
        end
        picture_file_size?(:int32).explain do
          description 'TODO: Description'
          example 'TODO: Example'
        end
        picture_updated_at?(:string).explain do
          description 'TODO: Description'
          example 'TODO: Example'
        end
        do_not_message_me(:bool).explain do
          description 'TODO: Description'
          example 'TODO: Example'
        end
        pin_messages_from(:bool).explain do
          description 'TODO: Description'
          example 'TODO: Example'
        end
        auto_follow(:bool).explain do
          description 'TODO: Description'
          example 'TODO: Example'
        end
        role(:int32).explain do
          description 'TODO: Description'
          example 'TODO: Example'
        end
        reset_password_token?(:string).explain do
          description 'TODO: Description'
          example 'TODO: Example'
        end
        reset_password_token_expires_at?(:string).explain do
          description 'TODO: Description'
          example 'TODO: Example'
        end
        reset_password_email_sent_at?(:string).explain do
          description 'TODO: Description'
          example 'TODO: Example'
        end
        product_account(:bool).explain do
          description 'TODO: Description'
          example 'TODO: Example'
        end
        chat_banned(:bool).explain do
          description 'TODO: Description'
          example 'TODO: Example'
        end
        designation(:string).explain do
          description 'TODO: Description'
          example 'TODO: Example'
        end
        recommended(:bool).explain do
          description 'TODO: Description'
          example 'TODO: Example'
        end
        gender(:int32).explain do
          description 'TODO: Description'
          example 'TODO: Example'
        end
        birthdate?(:string).explain do
          description 'TODO: Description'
          example 'TODO: Example'
        end
        city?(:string).explain do
          description 'TODO: Description'
          example 'TODO: Example'
        end
        country_code?(:string).explain do
          description 'TODO: Description'
          example 'TODO: Example'
        end
        biography?(:string).explain do
          description 'TODO: Description'
          example 'TODO: Example'
        end
        tester?(:bool).explain do
          description 'TODO: Description'
          example 'TODO: Example'
        end
      end
    end
  end
  output :success do
    status 200
    type :object do
      type :person_json
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

FanlinkApi::API.endpoint :update_person do
  method :put
  tag 'People'
  path '/people/{id}' do
    id :int32
  end
  input do
    type :object do
      person :object do
        username(:string).explain do
          description 'TODO: Description'
          example 'TODO: Example'
        end
        username_canonical(:string).explain do
          description 'TODO: Description'
          example 'TODO: Example'
        end
        email?(:string).explain do
          description 'TODO: Description'
          example 'TODO: Example'
        end
        name?(:string).explain do
          description 'TODO: Description'
          example 'TODO: Example'
        end
        product_id(:int32).explain do
          description 'TODO: Description'
          example 'TODO: Example'
        end
        crypted_password?(:string).explain do
          description 'TODO: Description'
          example 'TODO: Example'
        end
        salt?(:string).explain do
          description 'TODO: Description'
          example 'TODO: Example'
        end
        facebookid?(:string).explain do
          description 'TODO: Description'
          example 'TODO: Example'
        end
        facebook_picture_url?(:string).explain do
          description 'TODO: Description'
          example 'TODO: Example'
        end
        picture_file_name?(:string).explain do
          description 'TODO: Description'
          example 'TODO: Example'
        end
        picture_content_type?(:string).explain do
          description 'TODO: Description'
          example 'TODO: Example'
        end
        picture_file_size?(:int32).explain do
          description 'TODO: Description'
          example 'TODO: Example'
        end
        picture_updated_at?(:string).explain do
          description 'TODO: Description'
          example 'TODO: Example'
        end
        do_not_message_me(:bool).explain do
          description 'TODO: Description'
          example 'TODO: Example'
        end
        pin_messages_from(:bool).explain do
          description 'TODO: Description'
          example 'TODO: Example'
        end
        auto_follow(:bool).explain do
          description 'TODO: Description'
          example 'TODO: Example'
        end
        role(:int32).explain do
          description 'TODO: Description'
          example 'TODO: Example'
        end
        reset_password_token?(:string).explain do
          description 'TODO: Description'
          example 'TODO: Example'
        end
        reset_password_token_expires_at?(:string).explain do
          description 'TODO: Description'
          example 'TODO: Example'
        end
        reset_password_email_sent_at?(:string).explain do
          description 'TODO: Description'
          example 'TODO: Example'
        end
        product_account(:bool).explain do
          description 'TODO: Description'
          example 'TODO: Example'
        end
        chat_banned(:bool).explain do
          description 'TODO: Description'
          example 'TODO: Example'
        end
        designation(:string).explain do
          description 'TODO: Description'
          example 'TODO: Example'
        end
        recommended(:bool).explain do
          description 'TODO: Description'
          example 'TODO: Example'
        end
        gender(:int32).explain do
          description 'TODO: Description'
          example 'TODO: Example'
        end
        birthdate?(:string).explain do
          description 'TODO: Description'
          example 'TODO: Example'
        end
        city?(:string).explain do
          description 'TODO: Description'
          example 'TODO: Example'
        end
        country_code?(:string).explain do
          description 'TODO: Description'
          example 'TODO: Example'
        end
        biography?(:string).explain do
          description 'TODO: Description'
          example 'TODO: Example'
        end
        tester?(:bool).explain do
          description 'TODO: Description'
          example 'TODO: Example'
        end
      end
    end
  end
  output :success do
    status 200
    type :object do
      type :person_json
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

FanlinkApi::API.endpoint :destroy_person do
  method :delete
  tag 'People'
  path '/people/{id}' do
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
