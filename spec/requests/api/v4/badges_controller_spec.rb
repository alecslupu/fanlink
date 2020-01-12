require 'swagger_helper'

RSpec.describe "Api::V4::BadgesController", type: :request, swagger_doc: "v4/swagger.json" do
  path "/badges" do
    get "List of the badges" do
      security [Bearer: []]
      tags "Badges"

      produces "application/vnd.api.v4+json"
      consumes "multipart/form-data"

      let(:Authorization) { "" }
      let(:person) { create(:person) }

      parameter name: :page, in: :query, type: :integer, required: false, description: " Lorem ipsum", default: 1, minimum: 1
      parameter name: :per_page, in: :query, type: :integer, required: false, description: " Lorem ipsum", default: 25
      parameter name: :person_id, in: :query, type: :integer, required: false
      response "200", "" do
        let(:Authorization) { "Bearer #{::TokenProvider.issue_token(user_id: person.id)}" }
        schema "$ref": "#/definitions/BadgesArray"
        context "current_user" do
          let(:award) { create(:badge_award, person: person) }
          run_test!
        end
        context "other user" do
          let(:award) { create(:badge_award) }
          let(:person_id) { award.person_id }
          run_test!
        end

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

