require "swagger_helper"

RSpec.describe "Api::V4::PostReportsController", type: :request, swagger_doc: "v4/swagger.json" do
  path "/post_reports" do
    post "" do
      security [Bearer: []]

      tags "PostReports"

      produces "application/vnd.api.v4+json"
      consumes "multipart/form-data"

      parameter name: :"post_report[post_id]", in: :formData, type: :string, required: true
      parameter name: :"post_report[reason]", in: :formData, type: :string, required: true

      let(:Authorization) { "" }
      let(:person) { create(:person) }
      let("post_report[reason]") { "Lorem Ipsum" }
      let("post_report[post_id]") { create(:post).id }

      response "200", "" do
        let(:Authorization) { "Bearer #{::TokenProvider.issue_token(user_id: person.id)}" }

        run_test!
      end
      response 400, "Bad request" do
        document_response_without_test!
      end
      response "401", "" do
        run_test!
      end
      response "422", "" do
        let(:Authorization) { "Bearer #{::TokenProvider.issue_token(user_id: person.id)}" }
        let("post_report[reason]") { "Lorem Ipsum" * 60 }

        run_test!
      end

      response "404", "" do
        let("post_report[post_id]") { Time.zone.now.to_i }
        let(:Authorization) { "Bearer #{::TokenProvider.issue_token(user_id: person.id)}" }
        run_test!
      end
      response 500, "Internal server error" do
        document_response_without_test!
      end
    end
  end
end
