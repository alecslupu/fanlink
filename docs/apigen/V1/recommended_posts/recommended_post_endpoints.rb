class AddRecommendedPostEndpoints < Apigen::Migration
  def up
    add_endpoint :get_recommended_posts do
      method :get
      tag "Recommended Posts"
      path "/recommended_posts"
      output :success do
        status 200
        type :object do
          recommended_posts :array do
            type :post_response
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
  end
end
