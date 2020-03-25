class AddMessageEndpoints < Apigen::Migration
  def up
    add_endpoint :get_messages do
      description "This gets a list of message for a from date, to date, with an optional limit. Messages are returned newest first, and the limit is applied to that ordering."
      method :get
      tag "Messages"
      path "/rooms/{room_id}/messages" do
        room_id :int32
      end
      query do
        from_date(:date).explain do
          description "From date in format 'YYYY-MM-DD'. Note valid dates start from 2017-01-01."
          example "2017-01-01"
        end
        to_date(:date).explain do
          description "To date in format 'YYYY-MM-DD'. Note valid dates start from 2017-01-01."
          example "2017-01-01"
        end
        limit(:int32).explain do
          description "Limit results to count of limit."
          example 25
        end
      end
      output :success do
        status 200
        type :object do
          messages :array do
            type :message_response
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

    add_endpoint :list_messages do
      description "This gets a list of messages without regard to room (with possible exception of room filter).(Admin Only)"
      method :get
      tag "Messages"
      path "/messages/list"
      query do
        id_filter(:int32).explain do
          description "Full match on Message id."
        end
        person_filter(:string).explain do
          description "Full or partial match on person username."
        end
        room_id_filter(:int32).explain do
          description "Full match on Room id."
        end
        body_filter(:string).explain do
          description "Full or partial match on message body."
        end
        reported_filter(:string).explain do
          description "Filter on whether the message has been reported."
        end
      end
      output :success do
        status 200
        type :object do
          messages :array do
            type :message_list_response
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

    add_endpoint :get_a_message do
      description "This gets a single message for a message id. Only works for messages in private rooms. If the message author has been blocked by the current user, this will return 404 Not Found."
      method :get
      tag "Messages"
      path "/rooms/{room_id}/messages/{id}" do
        room_id :int32
        id :int32
      end
      output :success do
        status 200
        type :object do
          message :message_response
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

    add_endpoint :create_message do
      description "This creates a message in a room and posts it to Firebase as appropriate."
      method :post
      tag "Messages"
      path "/rooms/{room_id}/messages" do
        room_id :int32
      end
      input do
        type :object do
          message :object do
            body?(:string).explain do
              description "The body of the message."
              example "That was an awesome event."
            end
            picture?(:file).explain do
              description "Message picture, this should be `image/gif`, `image/png`, or `image/jpeg`."
            end
            audio?(:file).explain do
              description "Message audio, this should be `audio/aac`."
            end
            mentions? :object do
              person_id?(:int32).explain do
                description "ID of user mentioned"
                example 1
              end
              location?(:int32).explain do
                description "The location in the message body that the mention is at."
                example 25
              end
              length?(:int32).explain do
                description "The length of the users name in the mention"
                example 7
              end
            end
          end
        end
      end
      output :success do
        status 200
        type :object do
          message :message_response
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

    add_endpoint :update_message do
      description "This updates a message in a room. Only the hidden field can be changed and only by an admin. If the item is hidden, Firebase will be updated to inform the app that the message has been hidden."
      method :put
      tag "Messages"
      path "/rooms/{room_id}/messages/{id}" do
        room_id :int32
        id :int32
      end
      input do
        type :object do
          message :object do
            hidden(:bool).explain do
              description "Hide or unhide a message."
              example true
            end
          end
        end
      end
      output :success do
        status 200
        type :object do
          message :message_response
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

    add_endpoint :destroy_message do
      description "This deletes a single message by marking as hidden. Can only be called by the creator."
      method :delete
      tag "Messages"
      path "/rooms/{room_id}/messages/{id}" do
        room_id :int32
        id :int32
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