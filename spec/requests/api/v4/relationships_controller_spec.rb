# frozen_string_literal: true
require 'swagger_helper'

RSpec.describe "Api::V4::RelationshipsController", type: :request, swagger_doc: "v4/swagger.json" do

  path "/relationships" do
    post "" do
      security [Bearer: []]

      tags "Relationships"

      produces "application/vnd.api.v4+json"
      consumes "multipart/form-data"

      parameter name: :"relationship[requested_to_id]", in: :formData, type: :string

      let(:person) { create(:person) }
      let(:Authorization) { "" }
      let("relationship[requested_to_id]") { 1 }

      response "200", "HTTP/1.1 200 Ok" do
        let(:Authorization) { "Bearer #{::TokenProvider.issue_token(user_id: person.id)}" }
        let("relationship[requested_to_id]") { create(:person).id }

        schema "$ref": "#/definitions/RelationshipsObject"
        run_test!
      end
      response "422", "" do
        let(:relation) { create(:block, blocked: person) }
        let("relationship[requested_to_id]") { relation.blocker.id }

        let(:Authorization) { "Bearer #{::TokenProvider.issue_token(user_id: person.id)}" }
        run_test!
      end
      response "401", "" do
        run_test!
      end
      response "404", "" do
        let(:Authorization) { "Bearer #{::TokenProvider.issue_token(user_id: person.id)}" }
        let("relationship[requested_to_id]") { Time.zone.now.to_i }
        run_test!
      end
      response 500, "Internal server error" do
        document_response_without_test!
      end
    end
    get "" do
      security [Bearer: []]

      tags "Relationships"
      let(:Authorization) { "" }

      produces "application/vnd.api.v4+json"
      consumes "multipart/form-data"

      parameter name: :with_id, in: :query, type: :string, required: false
      parameter name: :person_id, in: :query, type: :string, required: false

      let(:relation) { create(:relationship) }
      context "all" do
        response "200", "HTTP/1.1 200 Ok" do
          let(:Authorization) { "Bearer #{::TokenProvider.issue_token(user_id: relation.requested_by.id)}" }
          schema "$ref": "#/definitions/RelationshipsArray"
          run_test!
        end
        response "401", "" do
          run_test!
        end
        response "404", "" do
          let(:Authorization) { "Bearer #{::TokenProvider.issue_token(user_id: relation.requested_by.id)}" }
          let(:person_id) { Time.zone.now.to_i }

          run_test!
        end
        response 500, "Internal server error" do
          document_response_without_test!
        end
      end
      context "with_id" do
        response "200", "HTTP/1.1 200 Ok" do
          let(:Authorization) { "Bearer #{::TokenProvider.issue_token(user_id: relation.requested_by.id)}" }
          let(:with_id) { relation.requested_to.id }
          schema "$ref": "#/definitions/RelationshipsArray"
          run_test!
        end
        response "401", "" do
          run_test!
        end
        response "404", "" do
          let(:Authorization) { "Bearer #{::TokenProvider.issue_token(user_id: relation.requested_by.id)}" }
          let(:with_id) { Time.zone.now.to_i }
          run_test!
        end
        response 500, "Internal server error" do
          document_response_without_test!
        end
      end
    end
  end

  path "/relationships/{id}" do
    delete "" do
      security [Bearer: []]
      tags "Relationships"
      let(:Authorization) { "" }
      let(:relation) { create(:relationship, status: 'friended') }
      let(:id) { 0 }

      parameter name: :id, in: :path, type: :string

      produces "application/vnd.api.v4+json"
      consumes "multipart/form-data"
      response "200", "HTTP/1.1 200 Ok" do
        let(:Authorization) { "Bearer #{::TokenProvider.issue_token(user_id: relation.requested_by.id)}" }
        let(:id) { relation.id }
        run_test!
      end
      response "401", "" do
        run_test!
      end
      response "404", "" do
        let(:Authorization) { "Bearer #{::TokenProvider.issue_token(user_id: relation.requested_by.id)}" }
        let(:id) { Time.zone.now.to_i }
        run_test!
      end
      response 500, "Internal server error" do
        document_response_without_test!
      end
    end
    patch "" do
      security [Bearer: []]
      tags "Relationships"
      let(:Authorization) { "" }

      parameter name: :id, in: :path, type: :string
      parameter name: :"relationship[status]", in: :formData, type: :string

      let(:relation) { create(:relationship, status: 'friended') }
      let(:id) { relation.id }
      let("relationship[status]") {  }

      produces "application/vnd.api.v4+json"
      consumes "multipart/form-data"
      context "denied" do

        response "200", "HTTP/1.1 200 Ok" do
          let(:Authorization) { "Bearer #{::TokenProvider.issue_token(user_id: relation.requested_to.id)}" }
          let(:relation) { create(:relationship, status: 'requested') }
          let("relationship[status]") { "denied" }
          run_test!
        end
        response "401", "" do
          run_test!
        end
        response "404", "" do
          let(:Authorization) { "Bearer #{::TokenProvider.issue_token(user_id: relation.requested_to.id)}" }
          let(:id) { Time.zone.now.to_i }
          run_test!
        end
        response "422", "" do
          let(:Authorization) { "Bearer #{::TokenProvider.issue_token(user_id: relation.requested_to.id)}" }
          let("relationship[status]") { "invalid" }
          run_test!
        end
        response 500, "Internal server error" do
          document_response_without_test!
        end
      end
      context "friended" do

        response "200", "HTTP/1.1 200 Ok" do
          let(:Authorization) { "Bearer #{::TokenProvider.issue_token(user_id: relation.requested_to.id)}" }
          let(:relation) { create(:relationship, status: 'requested') }
          schema "$ref": "#/definitions/RelationshipsObject"
          let("relationship[status]") { "friended" }
          run_test!
        end
        response "401", "" do
          run_test!
        end
        response "422", "" do
          let(:Authorization) { "Bearer #{::TokenProvider.issue_token(user_id: relation.requested_to.id)}" }
          let("relationship[status]") { "invalid" }

          run_test!
        end
        response "404", "" do
          let(:Authorization) { "Bearer #{::TokenProvider.issue_token(user_id: relation.requested_to.id)}" }
          let(:id) { Time.zone.now.to_i }
          run_test!
        end
        response 500, "Internal server error" do
          document_response_without_test!
        end
      end
      context "withdrawn" do

        response "200", "HTTP/1.1 200 Ok" do
          let(:Authorization) { "Bearer #{::TokenProvider.issue_token(user_id: relation.requested_by.id)}" }
          let(:relation) { create(:relationship, status: 'requested') }
          let("relationship[status]") { "withdrawn" }
          run_test!
        end
        response "422", "" do
          let(:Authorization) { "Bearer #{::TokenProvider.issue_token(user_id: relation.requested_by.id)}" }
          let(:relation) { create(:relationship, status: 'requested') }
          let("relationship[status]") { "invalid" }
          run_test!
        end
        response "401", "" do
          run_test!
        end
        response "404", "" do
          let(:Authorization) { "Bearer #{::TokenProvider.issue_token(user_id: relation.requested_by.id)}" }
          let(:relation) { create(:relationship, status: 'requested') }
          let(:id) { Time.zone.now.to_i }
          run_test!
        end
        response 500, "Internal server error" do
          document_response_without_test!
        end
      end
    end
  end

end
