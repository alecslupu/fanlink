require "swagger_helper"

RSpec.describe "Api::V4::MessageReportsController", type: :request, swagger_doc: "v4/swagger.json" do
  path "/message_reports" do
    get "" do
      security [Bearer: []]
      let(:Authorization) { "" }
      let(:person) { create(:admin_user) }
      let!(:message_reports) { ActsAsTenant.with_tenant(person.product) {  create(:message_report) } }

      parameter name: :status_filter, in: :query, type: :string, required: false
      parameter name: :page, in: :query, type: :integer, required: false, description: " Lorem ipsum", default: 1, minimum: 1
      parameter name: :per_page, in: :query, type: :integer, required: false, description: " Lorem ipsum", default: 25

      tags "MessageReports"
      produces "application/vnd.api.v4+json"

      response "200", "HTTP/1.1 200 Ok" do
        let(:Authorization) { "Bearer #{::TokenProvider.issue_token(user_id: person.id)}" }
        schema "$ref": "#/definitions/MessageReportsArray"
        run_test!
      end
      response "401", "Unauthorized." do
        run_test!
      end
      response 500, "Internal server error" do
        document_response_without_test!
      end
    end
  end
  path "/rooms/{room_id}/message_reports" do
    post "" do
      security [Bearer: []]
      tags "MessageReports" # 'android-old']

      produces "application/vnd.api.v4+json"
      consumes "multipart/form-data"

      parameter name: :room_id, in: :path, type: :string
      parameter name: :"message_report[message_id]", in: :formData, type: :string
      parameter name: :"message_report[reason]", in: :formData, type: :string

      let(:message) { create(:message, room: create(:public_active_room)) }
      let(:room) { message.room }
      let(:room_id) { room.id }
      let(:Authorization) { "" }

      let("message_report[message_id]") { message.id }
      let("message_report[reason]") { Faker::Lorem.sentence }

      response "200", "HTTP/1.1 200 Ok" do
        let(:Authorization) { "Bearer #{::TokenProvider.issue_token(user_id: room.created_by_id)}" }
        # schema "$ref": "#/definitions/OK"
        run_test!
      end
      response "422", "Unprocessable Entity. Usually occurs when a field is invalid or missing." do
        let(:Authorization) { "Bearer #{::TokenProvider.issue_token(user_id: room.created_by_id)}" }
        let("message_report[reason]") { Faker::Lorem.paragraph_by_chars(number: 750) }

        run_test!
      end
      response "401", "Unauthorized." do
        run_test!
      end
      response "404", "Not found." do
        let(:Authorization) { "Bearer #{::TokenProvider.issue_token(user_id: room.created_by_id)}" }
        let(:room_id) { 11 }
        run_test!
      end
      response 500, "Internal server error" do
        document_response_without_test!
      end
    end
  end
end
