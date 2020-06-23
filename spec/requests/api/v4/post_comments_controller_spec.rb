# frozen_string_literal: true

require 'swagger_helper'

RSpec.describe 'Api::V4::PostCommentsController', type: :request, swagger_doc: 'v4/swagger.json' do
  path '/posts/{id}/comments' do
    get '' do
      security [Bearer: []]
      tags 'PostComments'

      produces 'application/vnd.api.v4+json'
      consumes 'multipart/form-data'
      parameter name: :id, in: :path, type: :string

      let(:Authorization) { '' }
      let(:person) { create(:person) }
      let(:id) { create(:post, person: person).id }

      response '200', 'HTTP/1.1 200 Ok' do
        let(:Authorization) { "Bearer #{::TokenProvider.issue_token(user_id: person.id)}" }
        schema "$ref": '#/definitions/PostCommentsArray'

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
    post '' do
      security [Bearer: []]
      tags 'PostComments'

      produces 'application/vnd.api.v4+json'
      consumes 'multipart/form-data'
      parameter name: :id, in: :path, type: :string

      let(:Authorization) { '' }
      let(:person) { create(:person) }
      let(:id) { create(:post, person: person).id }

      parameter name: :"post_comment[body]", in: :formData, type: :string, required: true
      let('post_comment[body]') { 'a comment' }

      response '200', 'HTTP/1.1 200 Ok' do
        let(:Authorization) { "Bearer #{::TokenProvider.issue_token(user_id: person.id)}" }
        schema "$ref": '#/definitions/PostCommentsObject'

        run_test!
      end
      response 400, 'Bad request' do
        document_response_without_test!
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
  path '/posts/{post_id}/comments/{id}' do
    delete '' do
      security [Bearer: []]
      tags 'PostComments'

      produces 'application/vnd.api.v4+json'
      consumes 'multipart/form-data'

      parameter name: :post_id, in: :path, type: :string
      parameter name: :id, in: :path, type: :string
      let(:Authorization) { '' }
      let(:person) { create(:person) }

      let(:post_comment) { create(:post_comment, person: person) }
      let(:id) { post_comment.id }
      let(:post_id) { post_comment.post_id }

      response '200', 'HTTP/1.1 200 Ok' do
        let(:Authorization) { "Bearer #{::TokenProvider.issue_token(user_id: person.id)}" }
        run_test!
      end
      response '401', '' do
        run_test!
      end
      response '404', '' do
        let(:id) { Time.zone.now.to_i }
        let(:Authorization) { "Bearer #{::TokenProvider.issue_token(user_id: person.id)}" }

        run_test!
      end
      response 500, 'Internal server error' do
        document_response_without_test!
      end
    end
  end
end
