# frozen_string_literal: true
require 'swagger_helper'

RSpec.describe "Api::V4::NotificationDeviceIdsController", type: :request, swagger_doc: "v4/swagger.json" do
  path "/notification_device_ids" do
    post "" do
      tags "NotificationDeviceIds"
      security [Bearer: []]
      produces "application/vnd.api.v4+json"
      consumes "multipart/form-data"

      parameter name: :device_id, in: :formData, type: :string

      response "200", "HTTP/1.1 200 Ok" do
        let(:person) { FactoryBot.create(:person).reload}
        let(:Authorization) { "Bearer #{::TokenProvider.issue_token(user_id: person.id)}" }
        let(:device_id) { Faker::Crypto.sha1 }

        run_test!
      end

      response "401", "" do
        let(:Authorization) { "" }
        let(:device_id) { Faker::Crypto.sha1 }
        run_test!
      end

      response "422", "" do
        let(:person) { FactoryBot.create(:person).reload }
        let(:Authorization) { "Bearer #{::TokenProvider.issue_token(user_id: person.id)}" }
        let(:device_id) { "" }
        run_test!
      end


      response 500, "Internal server error" do
        let(:Authorization) { "" }
        let(:device_id) { Faker::Crypto.sha1 }
        document_response_without_test!
      end
    end
    delete "" do
      tags "NotificationDeviceIds"
      security [Bearer: []]

      produces "application/vnd.api.v4+json"
      consumes "multipart/form-data"

      parameter name: :device_id, in: :formData, type: :string

      response "200", "HTTP/1.1 200 Ok" do
        let(:device) { create(:notification_device_id)}
        let(:Authorization) { "Bearer #{::TokenProvider.issue_token(user_id: device.person.id)}" }
        let(:device_id) { device.device_identifier }

        run_test!
      end
      response "401", "" do
        let(:device) { create(:notification_device_id)}
        let(:Authorization) { "" }
        let(:device_id) { device.device_identifier }
        run_test!
      end
      response "404", "" do
        let(:device) { create(:notification_device_id)}
        let(:Authorization) { "Bearer #{::TokenProvider.issue_token(user_id: device.person.id)}" }
        let(:device_id) { "Faulty-#{device.device_identifier}"}
        run_test!
      end
      response 500, "Internal server error" do
        let(:Authorization) { "" }
        let(:device_id) { Faker::Crypto.sha1 }
        document_response_without_test!
      end
    end
  end
end
