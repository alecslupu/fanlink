# frozen_string_literal: true

require 'swagger_helper'

RSpec.describe 'Api::V4::PostsController', type: :request, swagger_doc: 'v4/swagger.json' do
  path '/posts' do
    get '' do
      security [Bearer: []]

      produces 'application/vnd.api.v4+json'
      #  consumes "multipart/form-data"
      tags 'Posts'

      let(:Authorization) { '' }
      let(:person) { create(:person) }
      let!(:posts) { create_list(:published_post, 2, person: person)}

      parameter name: :page, in: :query, type: :integer, required: false, description: ' Lorem ipsum', default: 1, minimum: 1
      parameter name: :per_page, in: :query, type: :integer, required: false, description: ' Lorem ipsum', default: 25

      parameter name: :promoted, in: :query, type: :string, required: false, enum: [:true, :false]
      parameter name: :post_id, in: :query, type: :string, required: false
      parameter name: :chronologically, in: :query, type: :string, required: false, enum: [:before, :after], default: :after

      parameter name: :tag, in: :query, type: :string, required: false
      parameter name: :categories, in: :query, type: :string, required: false
      parameter name: :person_id, in: :query, type: :string, required: false

      parameter name: :id_filter, in: :query, type: :string, required: false
      parameter name: :person_id_filter, in: :query, type: :string, required: false
      parameter name: :person_filter, in: :query, type: :string, required: false
      parameter name: :body_filter, in: :query, type: :string, required: false
      parameter name: :posted_after_filter, in: :query, type: :string, required: false
      parameter name: :posted_before_filter, in: :query, type: :string, required: false
      parameter name: :status_filter, in: :query, type: :string, required: false

      let(:tag) { '' }
      response '200', 'HTTP/1.1 200 Ok' do
        let(:Authorization) { "Bearer #{::TokenProvider.issue_token(user_id: person.id)}" }
        schema "$ref": '#/definitions/PostsArray'
        run_test!
      end
      response '401', 'Unauthorized.' do
        run_test!
      end
      response '422', 'Unprocessable Entity. Usually occurs when a field is invalid or missing.' do
        let(:person_id) { Time.zone.now.to_i }
        let(:Authorization) { "Bearer #{::TokenProvider.issue_token(user_id: person.id)}" }
        run_test!
      end
      response 500, 'Internal server error' do
        document_response_without_test!
      end
    end
    post '' do
      security [Bearer: []]
      tags 'Posts'

      produces 'application/vnd.api.v4+json'
      consumes 'multipart/form-data'

      let(:Authorization) { '' }
      let(:person) { create(:person) }

      parameter name: :"post[body]", in: :formData, type: :string, required: true
      parameter name: :"post[picture]", in: :formData, type: :file, required: true
      parameter name: :"post[audio]", in: :formData, type: :file, required: true
      parameter name: :"post[video]", in: :formData, type: :file, required: true

      let('post[body]') {}
      let('post[picture]') {}
      let('post[audio]') {}
      let('post[video]') {}

      response '200', 'HTTP/1.1 200 Ok' do
        let(:Authorization) { "Bearer #{::TokenProvider.issue_token(user_id: person.id)}" }
        schema "$ref": '#/definitions/PostsObject'

        run_test!
      end
      response '401', '' do
        run_test!
      end
      response '422', '' do
        document_response_without_test!
      end
      response 400, 'Bad request' do
        document_response_without_test!
      end
      response 500, 'Internal server error' do
        document_response_without_test!
      end
    end
  end
  path '/posts/{id}' do
    patch '' do
      security [Bearer: []]
      tags 'Posts'

      produces 'application/vnd.api.v4+json'
      consumes 'multipart/form-data'

      parameter name: :id, in: :path, type: :string
      let(:id) { create(:post, person: person).id }

      let(:Authorization) { '' }
      let(:person) { create(:person) }

      response '200', 'HTTP/1.1 200 Ok' do
        let(:Authorization) { "Bearer #{::TokenProvider.issue_token(user_id: person.id)}" }
        schema "$ref": '#/definitions/PostsObject'
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
    get '' do
      security [Bearer: []]
      tags 'Posts'

      produces 'application/vnd.api.v4+json'
      consumes 'multipart/form-data'

      parameter name: :id, in: :path, type: :string
      let(:id) { create(:post, person: person).id }

      let(:Authorization) { '' }
      let(:person) { create(:person) }

      response '200', 'HTTP/1.1 200 Ok' do
        let(:Authorization) { "Bearer #{::TokenProvider.issue_token(user_id: person.id)}" }
        schema "$ref": '#/definitions/PostsObject'
        run_test!
      end
      response '401', '' do
        run_test!
      end
      response '404', '' do
        let(:Authorization) { "Bearer #{::TokenProvider.issue_token(user_id: person.id)}" }
        let(:id) { Time.zone.now.to_i }
        # schema "$ref": "#/definitions/faulty"
        run_test!
      end
      response 500, 'Internal server error' do
        document_response_without_test!
      end
    end
    delete '' do
      security [Bearer: []]
      tags 'Posts'

      produces 'application/vnd.api.v4+json'
      consumes 'multipart/form-data'

      parameter name: :id, in: :path, type: :string
      let(:id) { create(:post, person: person).id }

      let(:Authorization) { '' }
      let(:person) { create(:person) }

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
