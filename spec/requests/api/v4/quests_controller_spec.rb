# frozen_string_literal: true
require "swagger_helper"

RSpec.describe "Api::V4::QuestsController", type: :request, swagger_doc: "v4/swagger.json" do

  path "/quests" do
    get "" do
      tags :quests
      security [Bearer: []]
      let(:Authorization) { "" }
      let(:person) { create(:person) }
      let(:quests) { create_list(:quest, 2) }

      parameter name: :page, in: :query, type: :integer, required: false, description: " Lorem ipsum", default: 1, minimum: 1
      parameter name: :per_page, in: :query, type: :integer, required: false, description: " Lorem ipsum", default: 25

      produces "application/vnd.api.v4+json"
      response "200", "HTTP/1.1 200 Ok" do
        let(:Authorization) { "Bearer #{::TokenProvider.issue_token(user_id: person.id)}" }
        schema "$ref": "#/definitions/QuestsArray"

        run_test!
      end
      response "401", "" do
        run_test!
      end
      # response "404", "" do
      #
      #   run_test!
      # end
      response 500, "Internal server error" do
        document_response_without_test!
      end
      #    tags ["quests", 'android-old']
    end
  end
  path "/quests/{id}" do
    get "" do
      tags :quests
      security [Bearer: []]
      let(:Authorization) { "" }
      parameter name: :id, in: :path, type: :string

      let(:id) { Time.zone.now.to_i }

      let(:quest) { create(:quest) }
      let(:person) { create(:person) }
      produces "application/vnd.api.v4+json"

      response "200", "HTTP/1.1 200 Ok" do
        let(:Authorization) { "Bearer #{::TokenProvider.issue_token(user_id: person.id)}" }
        let(:id) { quest.id }
        schema "$ref": "#/definitions/QuestObject"
        run_test!
      end
      response "401", "" do
        run_test!
      end
      response "404", "" do
        let(:Authorization) { "Bearer #{::TokenProvider.issue_token(user_id: person.id)}" }
        run_test!
      end
      response 500, "Internal server error" do
        document_response_without_test!
      end
      #    tags ["quests", 'android-old']
    end
  end
end

