# frozen_string_literal: true

require 'swagger_helper'

RSpec.describe 'Api::V4::PersonCertificatesController', type: :request, swagger_doc: 'v4/swagger.json' do
  path '/person_certificates/{unique_id}' do
    get 'Show the subscription information' do
      tags 'Certificates'
      produces 'application/vnd.api.v4+json'
      consumes 'application/vnd.api.v4+json'
      parameter name: :product, in: :query,  type: :string
      parameter name: :unique_id, in: :path, type: :string
      let(:unique_id) { 'Faulty' }
      let(:product) { create(:product).internal_name }

      response '200', 'HTTP/1.1 200 Ok' do
        let(:person_certificate) { create(:person_certificate) }
        let(:unique_id) { person_certificate.unique_id }
        let(:product) { person_certificate.person.product.internal_name }
        run_test!
      end

      response 404, '' do
        run_test!
      end

      response 500, 'Internal server error' do
        document_response_without_test!
      end
    end
  end

  path '/person_certificates' do
    post '' do
      security [Bearer: []]
      let(:Authorization) { '' }
      tags 'Certificates'

      parameter name: :certificate_id, type: :string, in: :formData, required: false
      parameter name: :"person_certificate[certificate_id]", type: :string, in: :formData, required: false
      parameter name: :"person_certificate[purchased_order_id]", type: :string, in: :formData, required: false
      parameter name: :"person_certificate[amount_paid]", type: :string, in: :formData, required: false
      parameter name: :"person_certificate[currency]", type: :string, in: :formData, required: false
      parameter name: :"person_certificate[purchased_sku]", type: :string, in: :formData, required: false
      parameter name: :"person_certificate[purchased_platform]", type: :string, in: :formData, required: false
      parameter name: :"person_certificate[receipt_id]", type: :string, in: :formData, required: false
      parameter name: :"person_certificate[full_name]", type: :string, in: :formData, required: false

      let(:person) { create(:person) }
      let(:certificate) { create(:certificate) }

      let(:certificate_id) { certificate.id }
      let('person_certificate[certificate_id]') { certificate.id }
      let('person_certificate[purchased_order_id]') { }
      let('person_certificate[amount_paid]') { Faker::Number.number(digits: 3) }
      let('person_certificate[currency]') { Faker::Currency.code }
      let('person_certificate[purchased_sku]') { }
      let('person_certificate[receipt_id]') { }

      produces 'application/vnd.api.v4+json'
      consumes 'multipart/form-data'
      response '200', 'HTTP/1.1 200 Ok' do
        let(:Authorization) { "Bearer #{::TokenProvider.issue_token(user_id: person.id)}" }
        schema "$ref": '#/definitions/CertificateObject'
        run_test!
      end
      response '401', '' do
        run_test!
      end
      response '422', '' do
        document_response_without_test!
      end
      response '404', '' do
        let(:Authorization) { "Bearer #{::TokenProvider.issue_token(user_id: person.id)}" }
        let(:certificate_id) { Time.zone.now.to_i }

        run_test!
      end
      response 500, 'Internal server error' do
        document_response_without_test!
      end
    end
  end
end

