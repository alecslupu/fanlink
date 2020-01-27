require "swagger_helper"

RSpec.describe "Api::V4::PostReportsController", type: :request, swagger_doc: "v4/swagger.json" do
  path "/message_reports" do
    get "" do
      security [Bearer: []]
      let(:Authorization) { "" }
      let(:person) { create(:admin_user) }

      parameter name: :status_filter, in: :query, type: :string, required: false
      parameter name: :page, in: :query, type: :integer, required: false, description: " Lorem ipsum", default: 1, minimum: 1
      parameter name: :per_page, in: :query, type: :integer, required: false, description: " Lorem ipsum", default: 25

      tags ["steps", 'android-old']
      produces "application/vnd.api.v4+json"

      response "200", "" do
        let(:Authorization) { "Bearer #{::TokenProvider.issue_token(user_id: person.id)}" }
        run_test!
      end
      response "401", "" do
        run_test!
      end
      response 500, "Internal server error" do
        document_response_without_test!
      end
    end
  end
end
