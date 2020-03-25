class AddPostCommentEndpoints < Apigen::Migration
  def up
    add_endpoint :get_post_comments do
      description "This gets all the non-hidden comments on a post with pagination."
      method :get
      tag "Post Comments"
      path "/post/{post_id}/comments" do
        post_id :int32
      end
      output :success do
        status 200
        type :object do
          post_comments :array do
            type :post_comment_response
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

    add_endpoint :list_post_comments do
      description "This gets a list of post comments with optional filters and pagination. (Admin Only)"
      method :get
      tag "Post Comments"
      path "/post/{post_id}/comments" do
        post_id :int32
      end
      query do
        body_filter(:string).explain do
          description "Full or partial match on comment body."
        end
        person_filter(:string).explain do
          description "Full or partial match on person username or email."
        end
      end
      output :success do
        status 200
        type :object do
          post_comments :array do
            type :post_comment_list_response
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

    add_endpoint :create_post_comment do
      description "This creates a post comment. It is automatically attributed to the logged in user."
      method :post
      tag "Post Comments"
      path "/posts/{post_id}/comments" do
        post_id :int32
      end
      input do
        type :object do
          post_comment :object do
            body(:string).explain do
              description "TODO: Description"
              example "TODO: Example"
            end
          end
          mentions? :object do
            person_id(:int32).explain do
              description "The id of the person mentioned."
              #Sexample
            end
            location(:int32).explain do
              description "Where the mention text starts in the comment."
              #example
            end
            length(:int32).explain do
              description "The length of the mention text."
              #example
            end
          end
        end
      end
      output :success do
        status 200
        type :object do
          post_comment :post_comment_response
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

    add_endpoint :destroy_post_comment do
      method :delete
      tag "Post Comments"
      path "/posts/{post_id}/comments/{id}" do
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
