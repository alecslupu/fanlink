# frozen_string_literal: true

require 'swagger_helper'

RSpec.describe 'Api::V4::PostReportsController', type: :request, swagger_doc: 'v4/swagger.json' do

  path '/post_comment_reports' do
    post '' do
      security [Bearer: []]
      tags 'PostCommentReports'
      let(:person) { create(:person) }
      let(:Authorization) { '' }

      parameter name: :"post_comment_report[post_comment_id]", in: :formData, type: :string, required: true
      parameter name: :"post_comment_report[reason]", in: :formData, type: :string, required: true

      let('post_comment_report[reason]') { 'Lorem Ipsum' }
      let('post_comment_report[post_comment_id]') { create(:post_comment_report).post_comment.id }


      produces 'application/vnd.api.v4+json'
      consumes 'multipart/form-data'

      response '200', 'HTTP/1.1 200 Ok' do
        let(:Authorization) { "Bearer #{::TokenProvider.issue_token(user_id: person.id)}" }
        run_test!
      end
      response '400', '' do
        document_response_without_test!
      end
      response '401', '' do
        run_test!
      end
      response '404', '' do
        let(:Authorization) { "Bearer #{::TokenProvider.issue_token(user_id: person.id)}" }
        let(:"post_comment_report[post_comment_id]") {Time.zone.now.to_i}
        run_test!
      end
      response 500, 'Internal server error' do
        document_response_without_test!
      end
    end
    get '' do
      security [Bearer: []]
      let(:Authorization) { '' }
      let(:person) { create(:admin_user) }
      tags 'PostCommentReports'

      parameter name: :status_filter, in: :query, type: :string, required: false
      parameter name: :page, in: :query, type: :integer, required: false, description: ' Lorem ipsum', default: 1, minimum: 1
      parameter name: :per_page, in: :query, type: :integer, required: false, description: ' Lorem ipsum', default: 25

      produces 'application/vnd.api.v4+json'

      response '200', 'HTTP/1.1 200 Ok' do
        let(:Authorization) { "Bearer #{::TokenProvider.issue_token(user_id: person.id)}" }
        schema "$ref": '#/definitions/PostCommentReportsArray'

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

end
