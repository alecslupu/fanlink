# frozen_string_literal: true

require 'swagger_helper'

RSpec.describe "Api::V4::Courseware::Client::PeopleController", type: :request, swagger_doc: "v4/swagger.json" do
  path "/courseware/client/people" do
    get "" do
      security [Bearer: []]
      let(:Authorization) { "" }
      tags "Courseware"
      parameter name: :page, in: :query, type: :integer, required: false, description: "", default: 1, minimum: 1
      parameter name: :per_page, in: :query, type: :integer, required: false, description: "", default: 25
      parameter name: :username_filter, in: :query, required: false, type: :string

      let(:person) { create(:client_user) }

      produces "application/vnd.api.v4+json"
      response "200", "HTTP/1.1 200 Ok" do
        let(:Authorization) { "Bearer #{::TokenProvider.issue_token(user_id: person.id)}" }
        schema "$ref": "#/definitions/MiniPeopleArray"
        let!(:people) { create_list(:client_to_person,3, client: person) }
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
