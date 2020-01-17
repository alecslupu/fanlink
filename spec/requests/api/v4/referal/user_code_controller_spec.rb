require 'swagger_helper'

RSpec.describe "Api::V4::Referal::UserCodeControllerSpec", type: :request, swagger_doc: "v4/swagger.json" do
  path "/people/referal/me" do
    get "List the referal code" do

      security [Bearer: []]
      tags "Referal"

      produces "application/vnd.api.v4+json"
      consumes "multipart/form-data"

      let(:Authorization) { "" }
      let(:person) { create(:person) }
      response "200", "" do
        let(:Authorization) { "Bearer #{::TokenProvider.issue_token(user_id: person.id)}" }
        schema "$ref": "#/definitions/ReferalCode"
        run_test!
      end

      response "401", "Unauthorized" do
        run_test!
      end
      response 500, "Internal server error" do
        document_response_without_test!
      end
    end
  end
end

