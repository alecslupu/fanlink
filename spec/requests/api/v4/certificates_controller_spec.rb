# frozen_string_literal: true

require 'swagger_helper'

RSpec.describe 'Api::V4::CertificatesController', type: :request, swagger_doc: 'v4/swagger.json' do
  path '/certificates' do
    get '' do
      security [Bearer: []]
      let(:Authorization) { '' }
      tags 'Courseware'
      produces 'application/vnd.api.v4+json'

      let(:person) { create(:person) }
      let!(:list) { create_list(:certificate, 5) }

      response '200', 'HTTP/1.1 200 Ok' do
        let(:Authorization) { "Bearer #{::TokenProvider.issue_token(user_id: person.id)}" }
        schema "$ref": '#/definitions/CertificatesArray'
        run_test!
      end
      response '401', '' do
        run_test!
      end
      response 500, 'Internal server error' do
        document_response_without_test!
      end
    end
  end
  path '/certificates/{id}' do
    get '' do
      security [Bearer: []]
      let(:Authorization) { '' }
      parameter name: :id, in: :path, type: :string
      tags 'Courseware'
      produces 'application/vnd.api.v4+json'

      let(:person) { create(:person) }
      let(:id) { create(:certificate).id }

      response '200', 'HTTP/1.1 200 Ok' do
        let(:Authorization) { "Bearer #{::TokenProvider.issue_token(user_id: person.id)}" }
        schema "$ref": '#/definitions/CertificateObject'
        run_test!
      end
      response '401', '' do
        run_test!
      end
      response '404', '' do
        let(:Authorization) { "Bearer #{::TokenProvider.issue_token(user_id: person.id)}" }
        let(:id) { Time.zone.now.to_i }
        run_test!
      end
      response 500, 'Internal server error' do
        document_response_without_test!
      end
    end
  end
end
