class AddPersonEndpoints < Apigen::Migration
  def up
    add_endpoint :get_people do
        description "This is used to get a list of people."
        method :get
        tag "People"
        path "/people"
        query do
          username_filter(:string).explain do
            description "A username or username fragment to filter on."
            example "Admin"
          end
          email_filter(:string).explain do
            description  "An email or email fragment to filter on."
            example "admin@example.com"
          end
        end
        output :success do
          status 200
          type :object do
            people :array do
              type :oneof do
                discriminator :type
                map(
                  person_response: "Public Person App Response",
                  person_private_response: "Private Person App Response"
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

    add_endpoint :get_a_person do
      description "Returns the person for the supplied ID."
      method :get
      tag "People"
      path "/people/{id}" do
        id :int32
      end
      output :success do
        status 200
        type :object do
          person :object do
            type :oneof do
              discriminator :type
              map(
                person_response: "Public Person App Response",
                person_private_response: "Private Person App Response"
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

    add_endpoint :create_person do
      description "This is used to create a new person.\nIf the account creation is successful, they will be logged in and we will send an onboarding email (if we have an email address for them)."
      method :post
      tag "People"
      path "/people"
      input do
        type :object do
          product(:string).explain do
            description "Internal name of the product."
          end
          person :object do
            username(:string).explain do
              description "Username. This needs to be unique within product scope."
              example "test_robot"
            end
            email?(:string).explain do
              description "Email address (required unless using FB auth token)." 
              example "hello@example.com"
            end
            name?(:string).explain do
              description "User's name."
              example "Test McTesterson"
            end
            facebook_auth_token!(:string).explain do
              description "Auth token from Facebook."
              #example "TODO: Example"
            end
            picture?(:file).explain do
              description "Profile picture, this should be `image/gif`, `image/png`, or `image/jpeg`."
              #example "TODO: Example"
            end
            # do_not_message_me(:bool).explain do
            #   description "TODO: Description"
            #   example "TODO: Example"
            # end
            # pin_messages_from(:bool).explain do
            #   description "TODO: Description"
            #   example "TODO: Example"
            # end
            # auto_follow(:bool).explain do
            #   description "TODO: Description"
            #   example "TODO: Example"
            # end
            # role(:int32).explain do
            #   description "TODO: Description"
            #   example "TODO: Example"
            # end
            # reset_password_token?(:string).explain do
            #   description "TODO: Description"
            #   example "TODO: Example"
            # end
            # reset_password_token_expires_at?(:string).explain do
            #   description "TODO: Description"
            #   example "TODO: Example"
            # end
            # reset_password_email_sent_at?(:string).explain do
            #   description "TODO: Description"
            #   example "TODO: Example"
            # end
            # product_account(:bool).explain do
            #   description "TODO: Description"
            #   example "TODO: Example"
            # end
            # chat_banned(:bool).explain do
            #   description "TODO: Description"
            #   example "TODO: Example"
            # end
            # designation(:string).explain do
            #   description "TODO: Description"
            #   example "TODO: Example"
            # end
            # recommended(:bool).explain do
            #   description "TODO: Description"
            #   example "TODO: Example"
            # end
            gender(:int32).explain do
              description  "Gender. Valid options: unspecified (default), male, female."
              example "TODO: Example"
            end
            birthdate?(:date).explain do
              description "Birthdate in format 'YYYY-MM-DD'."
              example "1970-08-02"
            end
            city?(:string).explain do
              description "Person's supplied city."
              example "Las Vegas"
            end
            country_code?(:string).explain do
              description "Alpha2 code (two letters) from ISO 3166 list."
              example "US"
            end
            # biography?(:string).explain do
            #   description "TODO: Description"
            #   example "TODO: Example"
            # end
            # tester?(:bool).explain do
            #   description "TODO: Description"
            #   example "TODO: Example"
            # end
          end
        end
      end
      output :success do
        status 200
        type :object do
          person :object do
            type :person_private_response
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

    add_endpoint :update_person do
      method :put
      tag "People"
      path "/people/{id}" do
        id :int32
      end
      input do
        type :object do
          recommended(:bool).explain do
            description "Whether this is a recommended persion. (Admin or product account only)"
          end
          person :object do
            username(:string).explain do
              description "Username. This needs to be unique within product scope."
              example "test_robot"
            end
            email?(:string).explain do
              description "Email address (required unless using FB auth token)." 
              example "hello@example.com"
            end
            name?(:string).explain do
              description "User's name."
              example "Test McTesterson"
            end
            picture?(:file).explain do
              description "Profile picture, this should be `image/gif`, `image/png`, or `image/jpeg`."
              #example "TODO: Example"
            end
            # do_not_message_me(:bool).explain do
            #   description "TODO: Description"
            #   example "TODO: Example"
            # end
            # pin_messages_from(:bool).explain do
            #   description "TODO: Description"
            #   example "TODO: Example"
            # end
            # auto_follow(:bool).explain do
            #   description "TODO: Description"
            #   example "TODO: Example"
            # end
            # role(:int32).explain do
            #   description "TODO: Description"
            #   example "TODO: Example"
            # end
            # reset_password_token?(:string).explain do
            #   description "TODO: Description"
            #   example "TODO: Example"
            # end
            # reset_password_token_expires_at?(:string).explain do
            #   description "TODO: Description"
            #   example "TODO: Example"
            # end
            # reset_password_email_sent_at?(:string).explain do
            #   description "TODO: Description"
            #   example "TODO: Example"
            # end
            # product_account(:bool).explain do
            #   description "TODO: Description"
            #   example "TODO: Example"
            # end
            # chat_banned(:bool).explain do
            #   description "TODO: Description"
            #   example "TODO: Example"
            # end
            # designation(:string).explain do
            #   description "TODO: Description"
            #   example "TODO: Example"
            # end
            # recommended(:bool).explain do
            #   description "TODO: Description"
            #   example "TODO: Example"
            # end
            gender(:int32).explain do
              description  "Gender. Valid options: unspecified (default), male, female."
              example "TODO: Example"
            end
            birthdate?(:date).explain do
              description "Birthdate in format 'YYYY-MM-DD'."
              example "1970-08-02"
            end
            city?(:string).explain do
              description "Person's supplied city."
              example "Las Vegas"
            end
            country_code?(:string).explain do
              description "Alpha2 code (two letters) from ISO 3166 list."
              example "US"
            end
            # biography?(:string).explain do
            #   description "TODO: Description"
            #   example "TODO: Example"
            # end
            # tester?(:bool).explain do
            #   description "TODO: Description"
            #   example "TODO: Example"
            # end
          end
        end
      end
      output :success do
        status 200
        type :object do
          person :object do
            type :person_private_response
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

    add_endpoint :change_password do
      description "This is used to change the logged in user's password."
      method :put
      tag "People"
      path "/people/{id}/change_password" do
        id :int32
      end
      input do
        type :object do
          person :object do
            current_password(:string).explain do
              description "The User's current password."
              example "SomeBoB#2213"
            end
            new_password(:string).explain do
              description "The new password."
              example "ThatOtherBoB#2214"
            end
          end
        end
      end
      output :success do
        status 200
        type :void
        description "HTTP/1.1 200 Ok"
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

# FanlinkApi::API.endpoint :destroy_person do
#   method :delete
#   tag "People"
#   path "/people/{id}" do
#     id :int32
#   end
#   output :success do
#     status 200
#     type :string
#   end

#   output :unauthorized do
#     status 401
#     type :object do
#       errors :object do
#         base :array do
#           type :string
#         end
#       end
#     end
#     description "User is not authorized to access this endpoint."
#   end

#   output :not_found do
#     status 404
#     type :object do
#       errors :object do
#         base :array do
#           type :string
#         end
#       end
#     end
#     description "The record was not found."
#   end

#   output :unprocessible do
#     status 422
#     type :object do
#       errors :object do
#         base :array do
#           type :string
#         end
#       end
#     end
#     description "One or more fields were invalid. Check response for reasons."
#   end

#   output :server_error do
#     status 500
#     type :object do
#       errors :object do
#         base :array do
#           type :string
#         end
#       end
#     end
#     description "Internal Server Error. Server threw an unrecoverable error. Create a ticket with any form fields you we're trying to send, the URL, API version number and any steps you took so that it can be replicated."
#   end
# end
