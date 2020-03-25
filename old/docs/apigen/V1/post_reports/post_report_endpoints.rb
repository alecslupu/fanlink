class AddPostReportEndpoints < Apigen::Migration
  def up
    add_endpoint :get_post_reports do
      method :get
      tag "Post Reports"
      path "/post_reports"
      description "Get Post Reports"
      output :success do
        status 200
        type :object do
          post_reports :array do
            type :post_report_response
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
        description "Internal Server Error. Server threw an unrecoverable error. Create a ticket with any form fields you were trying to send, the URL, API version number and any steps you took so that it can be replicated."
      end
    end

    add_endpoint :create_a_post_report do
      method :post
      tag "Post Reports"
      path '/post_reports'
      description 'Create a Post Report'
      input do
        type :object do
          post_report :object do
            post_id(:int32).explain do
              description ''
              example ''
            end
            person_id(:int32).explain do
              description ''
              example ''
            end
            reason?(:string).explain do
              description ""
              example ""
            end
            status(:int32).explain do
              description ""
              example ""
            end
          end
        end
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

    add_endpoint :update_a_post_report do
      method :put
      tag "Post Reports"
      path '/post_reports/{id}' do
        id :int32
      end
      description "Update a Post Report"
      input do
        type :object do
          post_report :object do
            status(:int32).explain do
              description "The new status for the report."
              #example ''
            end
          end
        end
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