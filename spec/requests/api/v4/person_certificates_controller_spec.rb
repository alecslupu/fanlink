require "swagger_helper"

RSpec.describe "Api::V4::Trivia::PersonCertificatesController", type: :request, swagger_doc: "v4/swagger.json" do
  path "/person_certificates/{unique_id}" do
    get "Show the subscription information" do
      tags "Certificates"
      produces "application/vnd.api.v4+json"
      parameter name: "X-App", in: :header, type: :string
      parameter name: "X-Current-Product", in: :header, type: :string
      parameter name: :unique_id, in: :path, type: :string
      response "200", "displays valid certificate" do
        let(:person_certificate)  { create(:person_certificate) }
        schema "$ref": "#/definitions/certificate_information"
        run_test!
      end

      response 404, "" do
        run_test!
      end

    end
  end
end
