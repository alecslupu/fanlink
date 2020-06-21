# frozen_string_literal: true

require "swagger_helper"

RSpec.describe "Api::V4::BlocksController", type: :request, swagger_doc: "v4/swagger.json" do
  path "/blocks" do
    post "" do

      security [Bearer: []]
      let(:Authorization) { "" }
      produces "application/vnd.api.v4+json"
      consumes "multipart/form-data"

      let(:blocker_id) { create(:person).id }
      let(:blocked) { create(:person) }
      let(:"block[blocked_id]") { blocked.id }

      parameter name: :"block[blocked_id]", in: :formData, type: :string

      response "200", "HTTP/1.1 200 Ok" do
        let(:Authorization) { "Bearer #{::TokenProvider.issue_token(user_id: blocker_id)}" }
        schema "$ref": "#/definitions/BlocksObject"

        run_test!
      end
      response "401", "" do
        run_test!
      end

      response "422", "" do
        let(:Authorization) { "Bearer #{::TokenProvider.issue_token(user_id: blocker_id)}" }
        let!(:block) { create(:block, blocker_id: blocker_id, blocked_id: blocked.id)}
        run_test!
      end
      response "404", "" do
        let(:Authorization) { "Bearer #{::TokenProvider.issue_token(user_id: blocker_id)}" }
        let(:"block[blocked_id]") { Time.zone.now.to_i }

        run_test!
      end
      response 500, "Internal server error" do
        document_response_without_test!
      end
      #    tags ["relation", 'android-old']
    end
  end

end
