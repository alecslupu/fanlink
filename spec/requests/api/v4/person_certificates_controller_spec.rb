require "swagger_helper"

RSpec.describe "Api::V4::Trivia::PersonCertificatesController", type: :request, swagger_doc: "v4/swagger.json" do
  path "/person_certificates/{unique_id}" do
    get "Show the subscription information" do
      tags "Certificates"
      produces "application/vnd.api.v4+json"
      consumes "application/vnd.api.v4+json"
      parameter name: :product, in: :query,  type: :string
      parameter name: :unique_id, in: :path, type: :string
      let(:unique_id) { "Faulty" }
      let(:product) { create(:product).internal_name }

      response "200", "displays valid certificate" do
       let(:person_certificate) { create(:person_certificate) }
       let(:unique_id) { person_certificate.unique_id }
       let(:product) { person_certificate.person.product.internal_name }
       schema "$ref": "#/definitions/certificate_information"
       run_test!
      end

      response 404, "" do
       run_test!
      end

      response 500, "Internal server error" do
        document_response_without_test!
      end
    end
  end
end

