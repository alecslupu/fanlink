# frozen_string_literal: true

require 'swagger_helper'

RSpec.describe 'Api::V4::LevelsController', type: :request, swagger_doc: 'v4/swagger.json' do
  path '/levels' do
    get '' do
      security [Bearer: []]
      tags 'Levels'

      produces 'application/vnd.api.v4+json'
      consumes 'multipart/form-data'

      let(:Authorization) { '' }
      let(:person) { create(:person) }

      parameter name: :page, in: :query, type: :integer, required: false, description: ' Lorem ipsum', default: 1, minimum: 1
      parameter name: :per_page, in: :query, type: :integer, required: false, description: ' Lorem ipsum', default: 25
      response '200', 'HTTP/1.1 200 Ok' do
        let(:Authorization) { "Bearer #{::TokenProvider.issue_token(user_id: person.id)}" }
        schema "$ref": '#/definitions/LevelsArray'

        run_test!
      end
      response '401', 'Unauthorized.' do
        run_test!
      end
      response 500, 'Internal server error' do
        document_response_without_test!
      end
    end
  end
end

