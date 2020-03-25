class AddPostReactionEndpoints < Apigen::Migration
    def up
      add_endpoint :create_post_reaction do
        description "This reacts to a post."
        method :post
        tag "Post Reactions"
        path "/posts/{post_id}/reactions" do
          post_id :int32
        end
        input do
          type :object do
            post_reaction :object do
              reaction(:string).explain do
                description "The identifier for the reaction. Accepts stringified hex values between 0 and 10FFFF, inclusive."
                #example "TODO: Example"
              end
            end
          end
        end
        output :success do
          status 200
          type :object do
            post_reaction :post_reaction_response
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

      add_endpoint :update_post_reaction do
        description "This updates a reaction on a post."
        method :put
        tag "Post Reactions"
        path "/posts/{post_id}/reactions/{id}" do
          post_id :int32
          id :int32
        end
        input do
          type :object do
            post_reaction :object do
              reaction(:string).explain do
                description "The identifier for the reaction. Accepts stringified hex values between 0 and 10FFFF, inclusive."
                #example "TODO: Example"
              end
            end
          end
        end
        output :success do
          status 200
          type :object do
            post_reaction :post_reaction_response
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
      
      add_endpoint :destroy_post_reaction do
        description "This updates a reaction on a post."
        method :delete
        tag "Post Reactions"
        path "/posts/{post_id}/reactions/{id}" do
            post_id :int32
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