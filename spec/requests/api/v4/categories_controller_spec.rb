# frozen_string_literal: true

require 'swagger_helper'

RSpec.describe 'Api::V4::CategoriesController', type: :request, swagger_doc: 'v4/swagger.json' do
  path '/categories' do
    get '' do
      security [Bearer: []]

      tags 'Categories'
      let(:Authorization) { '' }
      let(:categories) { create_list(:category, 3, role: :normal) }
      let(:person) { create(:person) }
      parameter name: :page, in: :query, type: :integer, required: false, description: ' Lorem ipsum', default: 1, minimum: 1
      parameter name: :per_page, in: :query, type: :integer, required: false, description: ' Lorem ipsum', default: 25
      parameter name: :product, in: :query, type: :string, required: false

      produces 'application/vnd.api.v4+json'
      response '200', 'HTTP/1.1 200 Ok' do
        let(:Authorization) { "Bearer #{::TokenProvider.issue_token(user_id: person.id)}" }
        schema "$ref": '#/definitions/CategoryArray'
        run_test!
      end
      response '401', 'Unauthorized. ' do
        document_response_without_test!
      end
      response '404', 'Not Found. If the error says a route is missing, it usually means you forgot the ACCEPT header.' do
        document_response_without_test!
      end
      response 500, "Internal Server Error. Server threw an unrecoverable error. Create a ticket with any form fields you we're trying to send, the URL, API version number and any steps you took so that it can be replicated." do
        document_response_without_test!
      end
    end
  end
end
