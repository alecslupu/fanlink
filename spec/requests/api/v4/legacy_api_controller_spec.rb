# frozen_string_literal: true

require 'swagger_helper'

RSpec.describe 'Api::V4::SessionController', type: :request, swagger_doc: 'v4/swagger.json' do
  path '/steps/{step_id}/completions' do
    post '' do
      security [Bearer: []]
      let(:Authorization) { '' }
      parameter name: :step_id, in: :path, type: :string
      let(:step_id) { Time.zone.now.to_i }
      produces 'application/vnd.api.v4+json'
      consumes 'multipart/form-data'

      response '200', 'HTTP/1.1 200 Ok' do
        # run_test!
        document_response_without_test!
      end
      response '401', '' do
        run_test!
      end
      response '404', '' do
        # run_test!
        document_response_without_test!
      end
      response 500, 'Internal server error' do
        document_response_without_test!
      end
      #    tags ["steps", 'android-old']
    end
  end
  #
  ## kotlin stuff
  path '/config/{requested_app}.json' do
    get '' do
      security [Bearer: []]
      let(:Authorization) { '' }
      parameter name: :requested_app, in: :path, type: :string

      produces 'application/vnd.api.v4+json'

      let(:requested_app) { 'some' }
      response '200', 'HTTP/1.1 200 Ok' do
        document_response_without_test!
      end
      response '404', '' do
        document_response_without_test!
      end
      response 500, 'Internal server error' do
        document_response_without_test!
      end
      #    tags ["config", 'kotlin']
    end
  end
  path '/people/person/{username}' do
    get '' do
      security [Bearer: []]
      let(:Authorization) { '' }
      parameter name: :username, in: :path, type: :string

      let(:username) { 'username' }

      produces 'application/vnd.api.v4+json'
      response '200', 'HTTP/1.1 200 Ok' do
        document_response_without_test!
      end
      response '401', '' do
        run_test!
      end
      response '404', '' do
        document_response_without_test!
      end
      response 500, 'Internal server error' do
        document_response_without_test!
      end
      #    tags ["user", 'kotlin']
    end
  end
  path '/people/recommended' do
    get '' do
      security [Bearer: []]
      let(:Authorization) { '' }
      produces 'application/vnd.api.v4+json'
      response '200', 'HTTP/1.1 200 Ok' do
        document_response_without_test!
      end
      response '401', '' do
        run_test!
      end
      response '404', '' do
        document_response_without_test!
      end
      response 500, 'Internal server error' do
        document_response_without_test!
      end
      #    tags ["user", 'kotlin']
    end
  end
  path '/people/send_certificate' do
    post '' do
      security [Bearer: []]
      let(:Authorization) { '' }
      produces 'application/vnd.api.v4+json'
      response '200', 'HTTP/1.1 200 Ok' do
        document_response_without_test!
      end
      response '401', '' do
        run_test!
      end
      response '404', '' do
        document_response_without_test!
      end
      response 500, 'Internal server error' do
        document_response_without_test!
      end
      #    tags ["education", 'kotlin']
    end
  end
end
