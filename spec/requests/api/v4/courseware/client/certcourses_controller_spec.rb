# frozen_string_literal: true

require 'swagger_helper'

RSpec.describe 'Api::V4::Courseware::Client::CertcoursesController', type: :request, swagger_doc: 'v4/swagger.json' do

  path '/courseware/client/people/{person_id}/certificates/{certificate_id}/certcourses' do
    get '' do
      security [Bearer: []]
      let(:Authorization) { '' }
      tags 'Courseware'
      parameter name: :person_id, in: :path, type: :string
      parameter name: :certificate_id, in: :path, type: :string

      let(:person) { create(:client_user) }
      let(:hired) { create(:person) }
      let(:certificate) { create(:person_certificate, person: hired) }
      let(:certificate_id) { certificate.certificate_id }
      let(:person_id) { hired.id }

      produces 'application/vnd.api.v4+json'
      response '200', 'HTTP/1.1 200 Ok' do
        let!(:relation) { create(:client_to_person, client: person, person: hired) }
        let(:Authorization) { "Bearer #{::TokenProvider.issue_token(user_id: person.id)}" }
        schema "$ref": '#/definitions/ClientCertcoursesArray'
        run_test!
      end
      response '401', '' do
        run_test!
      end
      response '422', '' do
        let!(:relation) { create(:client_to_person, client: person, person: hired) }

        let(:Authorization) { "Bearer #{::TokenProvider.issue_token(user_id: person.id)}" }
        let(:certificate_id) { Time.zone.now.to_i }

        run_test!
      end
      response 500, 'Internal server error' do
        document_response_without_test!
      end
    end
  end
  path '/courseware/client/people/{person_id}/certificates/{certificate_id}/certcourses/{id}' do
    get '' do
      security [Bearer: []]
      let(:Authorization) { '' }
      tags 'Courseware'
      parameter name: :person_id, in: :path, type: :string
      parameter name: :certificate_id, in: :path, type: :string
      parameter name: :id, in: :path, type: :string

      let(:certcourse) { create(:quiz_page, that_is_mandatory: true).certcourse_page.certcourse }
      let(:person) { create(:client_user) }
      let(:hired) { create(:person) }
      let(:person_certificate) { create(:person_certificate, person: hired) }
      let(:certificate_id) { person_certificate.certificate_id }
      let(:person_id) { hired.id }
      let(:id) { create(:certificate_certcourse, certificate: person_certificate.certificate, certcourse: certcourse).certcourse_id }

      produces 'application/vnd.api.v4+json'
      response '200', 'HTTP/1.1 200 Ok' do
        let!(:relation) { create(:client_to_person, client: person, person: hired) }
        let(:Authorization) { "Bearer #{::TokenProvider.issue_token(user_id: person.id)}" }
        schema "$ref": '#/definitions/ClientCertcourseQuizzArray'

        run_test!
      end
      response '401', '' do
        run_test!
      end
      response '404', '' do
        let!(:relation) { create(:client_to_person, client: person, person: hired) }

        let(:Authorization) { "Bearer #{::TokenProvider.issue_token(user_id: person.id)}" }
        let(:person_certificate) { create(:person_certificate, person: hired) }
        let(:certificate_id) { person_certificate.certificate_id }
        let(:id) { create(:certificate_certcourse, certificate: person_certificate.certificate ).certcourse_id }

        run_test!
      end
      response 500, 'Internal server error' do
        document_response_without_test!
      end
    end
  end

end
