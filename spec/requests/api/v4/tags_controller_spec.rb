# frozen_string_literal: true

require 'swagger_helper'

RSpec.describe 'Api::V4::TagsController', type: :request, swagger_doc: 'v4/swagger.json' do

  path '/posts/tags' do
    get '' do
      security [Bearer: []]
      tags 'Tags'

      produces 'application/vnd.api.v4+json'

      parameter name: :page, in: :query, type: :integer, required: false, description: ' Lorem ipsum', default: 1, minimum: 1
      parameter name: :per_page, in: :query, type: :integer, required: false, description: ' Lorem ipsum', default: 25
      parameter name: :tag_name, in: :query, type: :string, required: false, description: ' Lorem ipsum', default: 25

      let(:Authorization) { '' }
      let(:person) { create(:person) }

      response '200', 'HTTP/1.1 200 Ok' do
        let(:tag_name) { 'some_tag' }
        let(:Authorization) { "Bearer #{::TokenProvider.issue_token(user_id: person.id)}" }
        run_test!
      end
      response '401', '' do
        run_test!
      end
      response '422', '' do
        let(:Authorization) { "Bearer #{::TokenProvider.issue_token(user_id: person.id)}" }
        run_test!
      end
      response 500, 'Internal server error' do
        document_response_without_test!
      end
    end
  end
end
