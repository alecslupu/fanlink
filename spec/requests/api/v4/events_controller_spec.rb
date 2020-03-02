require "swagger_helper"

RSpec.describe "Api::V4::EventsController", type: :request, swagger_doc: "v4/swagger.json" do
  path "/events" do
    get "" do

      security [Bearer: []]
      let(:Authorization) { "" }
      produces "application/vnd.api.v4+json"
      response "200", "HTTP/1.1 200 Ok" do
        run_test!
      end
      response "401", "" do
        run_test!
      end
      response "404", "" do
        run_test!
      end
      response 500, "Internal server error" do
        document_response_without_test!
      end
      #    tags ["events", 'android-old']
    end
  end

  path "/events/{id}/checkins" do
    delete "" do
      security [Bearer: []]
      let(:Authorization) { "" }
      parameter name: :id, in: :path, type: :string
      let(:id) { Time.zone.now.to_i }

      produces "application/vnd.api.v4+json"
      response "200", "HTTP/1.1 200 Ok" do
        run_test!
      end
      response "401", "" do
        run_test!
      end
      response "404", "" do
        run_test!
      end
      response 500, "Internal server error" do
        document_response_without_test!
      end
      #    tags ["events", 'android-old']
      #
    end
    post "" do

      security [Bearer: []]
      let(:Authorization) { "" }
      produces "application/vnd.api.v4+json"
      consumes "multipart/form-data"

      let(:id) { Time.zone.now.to_i }

      response "200", "HTTP/1.1 200 Ok" do
        run_test!
      end
      response "401", "" do
        run_test!
      end
      response "404", "" do
        run_test!
      end
      response 500, "Internal server error" do
        document_response_without_test!
      end
      #    tags ["events", 'android-old']
      #
    end
    get "" do
      security [Bearer: []]
      let(:Authorization) { "" }
      produces "application/vnd.api.v4+json"
      let(:id) { Time.zone.now.to_i }
      response "200", "HTTP/1.1 200 Ok" do
        run_test!
      end
      response "401", "" do
        run_test!
      end
      response "404", "" do
        run_test!
      end
      response 500, "Internal server error" do
        document_response_without_test!
      end
      #    tags ["events", 'android-old']
    end
  end

end
