require 'swagger_helper'

RSpec.describe "Api::V4::PasswordResetsController", type: :request, swagger_doc: "v4/swagger.json" do

  path "/people/password_forgot" do
    post "" do
      tags "PasswordResets"

      produces "application/vnd.api.v4+json"
      consumes "multipart/form-data"
      parameter name: :product, in: :formData,  type: :string
      parameter name: :email_or_username, in: :formData, type: :string, required: false

      let(:user) { create(:person) }
      let(:product) { user.product.internal_name }
      let(:email_or_username) { user.email }


      response "200", "" do
        schema "$ref": "#/definitions/SuccessMessage"
        run_test!
      end
      response "422", "" do
        let(:product) { nil }

        schema "$ref": "#/definitions/ErrorMessage"
        run_test!
      end

      response 500, "Internal server error" do
        schema "$ref": "#/definitions/ErrorMessage"

        document_response_without_test!
      end
    end
  end
end
