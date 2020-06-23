# frozen_string_literal: true

require 'swagger_helper'

RSpec.describe 'Api::V4::PostReactionsController', type: :request, swagger_doc: 'v4/swagger.json' do

  path '/posts/{post_id}/reactions' do
    post '' do
      security [Bearer: []]
      tags 'Posts'

      parameter name: :post_id, in: :path, type: :string
      parameter name: :"post_reaction[reaction]", in: :formData, type: :string

      let(:Authorization) { '' }
      let(:person) { create(:person) }
      let(:post_id) { create(:post, person: person).id }
      let('post_reaction[reaction]') { build(:post_reaction).reaction }

      produces 'application/vnd.api.v4+json'
      consumes 'multipart/form-data'

      response '200', 'HTTP/1.1 200 Ok' do
        let(:Authorization) { "Bearer #{::TokenProvider.issue_token(user_id: person.id)}" }
        schema "$ref": '#/definitions/PostReactionsObject'
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
        let(:post_id) { Time.zone.now.to_i }

        run_test!
      end
      response 500, 'Internal server error' do
        document_response_without_test!
      end
    end

  end
  path '/posts/{post_id}/reactions/{id}' do
    delete '' do
      security [Bearer: []]
      tags 'Posts'

      parameter name: :id, in: :path, type: :string
      parameter name: :post_id, in: :path, type: :string

      let(:Authorization) { '' }
      let(:person) { create(:person) }
      let(:post) { create(:post, person: person) }
      let(:post_id) { post.id }
      let(:id) { create(:post_reaction, person: person, post: post).id }

      produces 'application/vnd.api.v4+json'
      response '200', 'HTTP/1.1 200 Ok' do
        let(:Authorization) { "Bearer #{::TokenProvider.issue_token(user_id: person.id)}" }
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
