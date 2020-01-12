require 'swagger_helper'

RSpec.describe "Api::V4::BadgeActionsController", type: :request, swagger_doc: "v4/swagger.json" do
  path "/badge_actions" do
    post "" do
      security [Bearer: []]
      tags "Badge"
      produces "application/vnd.api.v4+json"
      consumes "multipart/form-data"

      parameter name: :"badge_action[action_type]", type: :string, in: :formData
      let(:Authorization) { "" }
      let(:badge_action) { create(:badge_action) }
      let("badge_action[action_type]") { }

      response "200", "" do
        let(:Authorization) { "Bearer #{::TokenProvider.issue_token(user_id: badge_action.person_id)}" }
        let(:badge) { create(:badge, action_type: badge_action.action_type)}
        let("badge_action[action_type]") {  badge.action_type.internal_name }

        schema "$ref": "#/definitions/faulty"
        run_test!
      end
      response "401", "" do
        run_test!
      end
      response "404", "" do
        let(:Authorization) { "Bearer #{::TokenProvider.issue_token(user_id: badge_action.person_id)}" }
        let("badge_action[action_type]") {  badge_action.action_type.internal_name }

        run_test!
      end
      response "422", "" do
        let(:Authorization) { "Bearer #{::TokenProvider.issue_token(user_id: badge_action.person_id)}" }

        run_test!
      end
      response 500, "Internal server error" do
        document_response_without_test!
      end
    end
  end
end

