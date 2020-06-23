# frozen_string_literal: true

require 'swagger_helper'

RSpec.describe 'Api::V4::BadgeActionsController', type: :request, swagger_doc: 'v4/swagger.json' do
  path '/badge_actions' do
    post 'POST create a badge action' do
      security [Bearer: []]
      tags 'BadgeActions'
      produces 'application/vnd.api.v4+json'
      consumes 'multipart/form-data'

      parameter name: :"badge_action[action_type]", type: :string, in: :formData
      let(:Authorization) { '' }
      let(:badge_action) { create(:badge_action) }
      let('badge_action[action_type]') {}

      response '200', 'HTTP/1.1 200 Ok' do
        let(:Authorization) { "Bearer #{::TokenProvider.issue_token(user_id: badge_action.person_id)}" }
        let(:badge) { create(:badge, action_type: badge_action.action_type) }
        let('badge_action[action_type]') { badge.action_type.internal_name }

        schema "$ref": '#/definitions/BadgeActionsPending'
        run_test!
      end
      response '401', 'Unauthorized.' do
        run_test!
      end
      response '404', 'Not found. A reward is not associated with the badge action' do
        let(:Authorization) { "Bearer #{::TokenProvider.issue_token(user_id: badge_action.person_id)}" }
        let('badge_action[action_type]') { badge_action.action_type.internal_name }
        run_test!
      end
      response '422', 'Unprocessable Entity. Usually occurs when a field is invalid or missing.' do
        let(:Authorization) { "Bearer #{::TokenProvider.issue_token(user_id: badge_action.person_id)}" }
        run_test!
      end
      response 429, 'Not enough time since last submission of this action type or duplicate action type, person, identifier combination' do
        document_response_without_test!
      end
      response 500, "Internal Server Error. Server threw an unrecoverable error. Create a ticket with any form fields you we're trying to send, the URL, API version number and any steps you took so that it can be replicated." do
        document_response_without_test!
      end
    end
  end
end
