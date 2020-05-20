# frozen_string_literal: true
require 'swagger_helper'

RSpec.describe "Api::V4::Referral::UserCodeControllerSpec", type: :request, swagger_doc: "v4/swagger.json" do
  path "/people/referral/me" do
    get "List the referral code" do

      security [Bearer: []]
      tags "Referral"

      produces "application/vnd.api.v4+json"
      consumes "multipart/form-data"

      let(:Authorization) { "" }
      let(:person) { create(:person) }
      response "200", "" do
        let(:Authorization) { "Bearer #{::TokenProvider.issue_token(user_id: person.id)}" }
        schema "$ref": "#/definitions/ReferralCode"
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
