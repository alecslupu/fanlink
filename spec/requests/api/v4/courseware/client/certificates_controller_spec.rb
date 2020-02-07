require 'swagger_helper'

RSpec.describe "Api::V4::Courseware::Client::CertificatesController", type: :request, swagger_doc: "v4/swagger.json" do
  path "/courseware/client/people/{person_id}/certificates" do
    get "" do
      security [Bearer: []]
      let(:Authorization) { "" }
      # tags "Courseware-tst"
      parameter name: :person_id, in: :path, type: :string

      let(:person) { create(:client_user) }
      let(:hired) { create(:person) }

      let(:person_id) { hired.id }

      produces "application/vnd.api.v4+json"
      response "200", "HTTP/1.1 200 Ok" do
        let!(:relation) { create(:client_to_person, client: person, person: hired) }
        let!(:person_certificate) { create(:person_certificate, person: hired ) }
        let(:Authorization) { "Bearer #{::TokenProvider.issue_token(user_id: person.id)}" }

        run_test!
      end
      response "401", "" do
        run_test!
      end
      response "404", "" do
        let(:Authorization) { "Bearer #{::TokenProvider.issue_token(user_id: person.id)}" }
        let(:person_id) { Time.zone.now.to_i }

        run_test!
      end
      response 500, "Internal server error" do
        document_response_without_test!
      end
    end
  end
  # path "/courseware/client/people/{person_id}/certificates/{id}" do
  #   get "" do
  #     security [Bearer: []]
  #     let(:Authorization) { "" }
  #     # tags "Courseware-tst"
  #     parameter name: :person_id, in: :path, type: :string
  #     parameter name: :id, in: :path, type: :string
  #
  #     produces "application/vnd.api.v4+json"
  #     response "200", "HTTP/1.1 200 Ok" do
  #       run_test!
  #     end
  #     response "401", "" do
  #       run_test!
  #     end
  #     response "404", "" do
  #       run_test!
  #     end
  #     response 500, "Internal server error" do
  #       document_response_without_test!
  #     end
  #   end
  # end

end
