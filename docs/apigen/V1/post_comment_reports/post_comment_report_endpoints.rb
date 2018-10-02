class AddPostCommentReportEndpoints < Apigen::Migration
    def up
      add_endpoint :get_post_comment_reports do
        description "This gets a list of post comment reports with optional filter. (Admin Only)"
        method :get
        tag "Post Comment Reports"
        path "/post_comment_reports"
        query do
          status_filter(:string).explain do
            description "If provided, valid values are 'pending', 'no_action_needed', and 'comment_hidden'"
          end
        end
        output :success do
          status 200
          type :object do
            post_comment_reports :array do
              type :post_comment_report_response
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

      add_endpoint :create_a_post_comment_report do
        description "This reports a post comment."
        method :post
        tag "Post Comment Reports"
        path "/post_comment_reports"
        input do
          type :object do
            post_comment_report :object do
              post_comment_id(:int32).explain do
                description "The id of the post comment being reported." 
                example 1
              end
              reason?(:string).explain do
                description "The reason given by the user for reporting the post comment."
                example "Harrassment"
              end
            end
          end
        end
        output :success do
          status 200
          type :object do
            post_comment_report :object do
              type :post_comment_report_response
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

      add_endpoint :update_a_post_comment_report do
        description "This updates a post comment report. The only value that can be changed is the status."
        method :put
        tag "Post Comment Reports"
        path "/post_comment_reports/{id}" do
          id :int32
        end
        input do
          type :object do
            post_comment_report :object do
              status(:int32).explain do
                description "The new status. Valid statuses are 'pending', 'no_action_needed', 'comment_hidden'."
                #example "TODO: Example"
              end
            end
          end
        end
        output :success do
          status 200
          type :string
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

# FanlinkApi::API.endpoint :get_a_post_comment_report do
#   method :get
#   tag "Post Comment Reports"
#   path "/post_comment_reports/{id}" do
#     id :int32
#   end
#   output :success do
#     status 200
#     type :object do
#       type :post_comment_report_response
#     end
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

# FanlinkApi::API.endpoint :destroy_a_post_comment_report do
#   method :delete
#   tag "Post Comment Reports"
#   path "/post_comment_reports/{id}" do
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
