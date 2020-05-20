# frozen_string_literal: true
require "swagger_helper"

RSpec.describe "Api::V4::EventsController", type: :request, swagger_doc: "v4/swagger.json" do
  path "/events" do
    get "" do
      tags "events"
      security [Bearer: []]
      let(:Authorization) { "" }
      produces "application/vnd.api.v4+json"

      parameter name: :page, in: :query, type: :integer, required: false, description: "", default: 1, minimum: 1
      parameter name: :per_page, in: :query, type: :integer, required: false, description: "", default: 25
      parameter name: :product, in: :query, type: :string, required: false, description: "", default: 25
      # YYYY-MM-DD
      parameter name: :from_date, in: :query, type: :string, required: false, description: "", default: 1, minimum: 1
      parameter name: :to_date, in: :query, type: :string, required: false, description: "", default: 1, minimum: 1
      let(:person) { create(:person) }
      let!(:events) { ActsAsTenant.with_tenant(person.product) { create_list(:event, 10, ends_at: 1.week.from_now) } }
      let(:product) { person.product }

      response "200", "HTTP/1.1 200 Ok" do
        schema "$ref": "#/definitions/EventsArray"
        run_test!
      end
      response "422", "" do
        let(:product) { "faulty" }
        run_test!
      end
      response 500, "Internal server error" do
        document_response_without_test!
      end
    end
  end
  path "/events/{id}/checkins" do
    delete "" do
      tags "events"
      security [Bearer: []]
      let(:Authorization) { "" }
      parameter name: :id, in: :path, type: :string
      let(:id) { Time.zone.now.to_i }
      let(:event_checkin) {create(:event_checkin)}

      produces "application/vnd.api.v4+json"
      response "200", "HTTP/1.1 200 Ok" do
        let(:Authorization) { "Bearer #{::TokenProvider.issue_token(user_id: event_checkin.person_id)}" }
        let(:id) { event_checkin.event_id }
        run_test!
      end
      response "401", "" do
        run_test!
      end
      response "404", "" do
        let(:Authorization) { "Bearer #{::TokenProvider.issue_token(user_id: event_checkin.person_id)}" }
        let(:id) { Time.zone.now.to_i }
        run_test!
      end
      response 500, "Internal server error" do
        document_response_without_test!
      end
    end
    post "" do
      tags "events"
      security [Bearer: []]
      let(:Authorization) { "" }
      produces "application/vnd.api.v4+json"
      consumes "multipart/form-data"
      parameter name: :id, in: :path, type: :string
      let(:id) { Time.zone.now.to_i }

      let(:person) { create(:person)}
      let(:event) { create(:event)}

      response "200", "HTTP/1.1 200 Ok" do
        let(:Authorization) { "Bearer #{::TokenProvider.issue_token(user_id: person.id)}" }
        let(:id) { event.id }
        schema "$ref": "#/definitions/EventCheckinJson"
        run_test!
      end
      response "401", "" do
        run_test!
      end
      response "404", "" do
        let(:Authorization) { "Bearer #{::TokenProvider.issue_token(user_id: person.id)}" }
        run_test!
      end
      response "422", "" do
        let(:event_checkin) {create(:event_checkin)}
        let(:Authorization) { "Bearer #{::TokenProvider.issue_token(user_id: event_checkin.person_id)}" }
        let(:id) { event_checkin.event_id }
        run_test!
      end
      response 500, "Internal server error" do
        document_response_without_test!
      end
    end
    get "" do
      tags "events"
      security [Bearer: []]
      let(:Authorization) { "" }
      produces "application/vnd.api.v4+json"
      parameter name: :id, in: :path, type: :string

      parameter name: :page, in: :query, type: :integer, required: false, description: "", default: 1, minimum: 1
      parameter name: :per_page, in: :query, type: :integer, required: false, description: "", default: 25
      parameter name: :interst_id, in: :query, type: :integer, required: false, description: ""

      let(:id) { Time.zone.now.to_i }
      let(:person) { create(:person)}
      let(:event) { create(:event)}
      let!(:event_checkins) { create_list(:event_checkin, 20, event: event)}

      response "200", "HTTP/1.1 200 Ok" do
        let(:Authorization) { "Bearer #{::TokenProvider.issue_token(user_id: person.id)}" }
        schema "$ref": "#/definitions/EventCheckinArray"
        let(:id) { event.id }
        run_test!
      end
      response "401", "" do
        let(:id) { event.id }
        run_test!
      end
      response "404", "" do
        let(:id) { Time.zone.now.to_i }
        let(:Authorization) { "Bearer #{::TokenProvider.issue_token(user_id: person.id)}" }
        run_test!
      end
      response 500, "Internal server error" do
        document_response_without_test!
      end
    end
  end
end
