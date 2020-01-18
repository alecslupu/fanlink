require 'swagger_helper'

RSpec.describe "Api::V4::Referal::ReferalController", type: :request, swagger_doc: "v4/swagger.json" do
  path "/people/referal" do
    get "List the referal code" do

      security [Bearer: []]
      tags "Referal"

      produces "application/vnd.api.v4+json"
      consumes "multipart/form-data"
      parameter name: :page, in: :query, type: :integer, required: false, description: " Lorem ipsum", default: 1, minimum: 1
      parameter name: :per_page, in: :query, type: :integer, required: false, description: " Lorem ipsum", default: 25

      let(:Authorization) { "" }
      let(:person) { create(:person) }
      response "200", "" do
        let(:Authorization) { "Bearer #{::TokenProvider.issue_token(user_id: person.id)}" }
        schema "$ref": "#/definitions/MiniPeopleArray"
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

  path "/people/referal/purchased" do
    get "List the referal code" do

      security [Bearer: []]
      tags "Referal"

      parameter name: :page, in: :query, type: :integer, required: false, description: " Lorem ipsum", default: 1, minimum: 1
      parameter name: :per_page, in: :query, type: :integer, required: false, description: " Lorem ipsum", default: 25

      produces "application/vnd.api.v4+json"
      consumes "multipart/form-data"

      let(:Authorization) { "" }
      let(:person) { create(:person) }
      response "200", "" do
        let(:Authorization) { "Bearer #{::TokenProvider.issue_token(user_id: person.id)}" }
        schema "$ref": "#/definitions/MiniPeopleArray"
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
