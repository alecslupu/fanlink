require 'swagger_helper'

RSpec.describe "Api::V4::NotificationDeviceIdsController", type: :request, swagger_doc: "v4/swagger.json" do
  path "/notification_device_ids" do
    post "" do
      security [Bearer: []]

      produces "application/vnd.api.v4+json"
      consumes "multipart/form-data"
      parameter name: :device_id, in: :formData, type: :string

      response "200", "" do
        before do |example|
          submit_request(example.metadata)
        end

        let!(:person) { create(:person) }
        let(:Authorization) { "Bearer #{::TokenProvider.issue_token( user_id: person.id ) }" }
        let(:device_id) { 'dfadfa' }

        it "should insert a new device id" do
          expect(person.notification_device_ids.where(device_identifier: "dfadfa").exists?).to be_truthy
        end
      end
      response "401", "" do
        let(:Authorization) { "Bearer empgg" }
        let(:device_id) { 'dfadfa' }

        run_test!
      end
      response "422", "" do
        before do |example|
          submit_request(example.metadata)
        end

        let!(:person) { create(:person) }
        let(:Authorization) { "Bearer #{::TokenProvider.issue_token( user_id: person.id ) }" }
        let(:device_id) { '' }

        run_test!
      end
      #response "404", "" do
      #  let(:device_id) { "aaa" }
      #  run_test!
      #end
    end
    #delete "" do
    #  produces "application/vnd.api.v4+json"
    #  consumes "multipart/form-data"
    #  parameter name: :device_id, in: :formData, type: :string
    #
    #  response "200", "" do
    #    let(:device_id) { "aaa" }
    #    run_test!
    #  end
    #  response "401", "" do
    #    let(:device_id) { "aaa" }
    #    run_test!
    #  end
    #  response "404", "" do
    #    let(:device_id) { "aaa" }
    #    run_test!
    #  end
    #end
  end
end
