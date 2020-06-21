# frozen_string_literal: true

require 'swagger_helper'

RSpec.describe "Api::V4::FollowingsController", type: :request, swagger_doc: "v4/swagger.json" do

  path "/followings" do
    post "" do
      security [Bearer: []]

      tags "Followings"# , 'kotlin']

      parameter name: :followed_id, in: :formData, type: :string

      let(:Authorization) { "" }
      let(:person) { create(:person) }
      let(:followed_id) { 0 }

      produces "application/vnd.api.v4+json"
      consumes "multipart/form-data"
      response "200", "HTTP/1.1 200 Ok" do
        let(:Authorization) { "Bearer #{::TokenProvider.issue_token(user_id: person.id)}" }
        let(:followed_id) { create(:person).id }
        schema "$ref": "#/definitions/FollowingObject"

        run_test!
      end
      response "401", "Unauthorized" do
        run_test!
      end
      response 500, "Internal server error" do
        document_response_without_test!
      end
    end
    get "" do
      security [Bearer: []]

      tags "Followings"# , 'kotlin']
      let(:Authorization) { "" }
      let(:person) { create(:person) }
      parameter name: :page, in: :query, type: :integer, required: false, description: " Lorem ipsum", default: 1, minimum: 1
      parameter name: :per_page, in: :query, type: :integer, required: false, description: " Lorem ipsum", default: 25
      parameter name: :followed_id, in: :formData, type: :string, required: false
      parameter name: :follower_id, in: :formData, type: :string, required: false

      produces "application/vnd.api.v4+json"
      consumes "multipart/form-data"
      context "" do
        # followed_id
        response "200", "HTTP/1.1 200 Ok" do
          let(:Authorization) { "Bearer #{::TokenProvider.issue_token(user_id: person.id)}" }
          let(:followed_id) { create(:following, followed: person).followed_id }
          schema "$ref": "#/definitions/FollowersArray"

          run_test!
        end
        response "401", "Unauthorized" do
          run_test!
        end
        response "404", "Not found" do
          let(:Authorization) { "Bearer #{::TokenProvider.issue_token(user_id: person.id)}" }
          let(:followed_id) { Time.zone.now.to_i }
          run_test!
        end
        response 500, "Internal server error" do
          document_response_without_test!
        end
      end
      context "" do
        # followed_id
        response "200", "HTTP/1.1 200 Ok" do
          let(:Authorization) { "Bearer #{::TokenProvider.issue_token(user_id: person.id)}" }
          let(:follower_id) { create(:following, followed: person).follower_id }
          schema "$ref": "#/definitions/FollowersArray"
          run_test!
        end
        response "401", "" do
          run_test!
        end
        response "404", "" do
          let(:Authorization) { "Bearer #{::TokenProvider.issue_token(user_id: person.id)}" }
          let(:follower_id) { Time.zone.now.to_i }
          run_test!
        end
        response 500, "Internal server error" do
          document_response_without_test!
        end
      end

    end
  end
end
