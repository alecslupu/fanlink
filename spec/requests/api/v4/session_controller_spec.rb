require "swagger_helper"

RSpec.describe "Api::V4::SessionController", type: :request, swagger_doc: "v4/swagger.json" do

  path "/session/token" do
    post "generates a  valid JWT" do
      tags "Session"
      produces "application/vnd.api.v4+json"

      consumes "multipart/form-data"
      parameter name: :email_or_username, in: :formData, type: :string
      parameter name: :password, in: :formData, type: :string
      parameter name: :product, in: :formData, type: :string
      # parameter name: "X-App", in: :header, type: :string
      # parameter name: "X-Current-Product", in: :header, type: :string

      response "200", "" do
        let!(:user) { create(:person) }
        schema "$ref": "#/definitions/session_jwt"

        run_test!
      end

      response 422, "" do
        run_test!
      end
    end
  end
end
