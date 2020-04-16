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

      let!(:static_system_email) { create(:static_system_email, name: "password-reset")  }

      response "200", "HTTP/1.1 200 Ok" do
        run_test!
      end
      response "422", "" do
        let(:product) { nil }

        run_test!
      end

      response 500, "Internal server error" do
        document_response_without_test!
      end
    end
  end
end
