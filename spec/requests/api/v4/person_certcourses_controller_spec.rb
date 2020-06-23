# frozen_string_literal: true

require 'swagger_helper'

RSpec.describe 'Api::V4::PersonCertcoursesController', type: :request, swagger_doc: 'v4/swagger.json' do
  path '/person_certcourses/send_email' do
    post '' do
      security [Bearer: []]
      let(:Authorization) { '' }
      let(:person_certcourse) { create(:person_certcourse) }

      tags 'Courseware'

      produces 'application/vnd.api.v4+json'
      consumes 'multipart/form-data'

      parameter name: :page_id, in: :formData, type: :string, required: false
      let(:certcourse_page) { create(:certcourse_page, certcourse: person_certcourse.certcourse) }
      let(:download_file_page) { create(:download_file_page, certcourse_page: certcourse_page) }
      let(:page_id) { download_file_page.certcourse_page.id }
      let!(:static_system_email) { create(:static_system_email, name: 'document-download') }

      response '200', 'HTTP/1.1 200 Ok' do
        let(:Authorization) { "Bearer #{::TokenProvider.issue_token(user_id: person_certcourse.person.id)}" }
        run_test!
      end
      response '401', '' do
        run_test!
      end
      response '404', '' do
        let(:Authorization) { "Bearer #{::TokenProvider.issue_token(user_id: person_certcourse.person.id)}" }
        let(:page_id) { Time.zone.now.to_i }

        run_test!
      end
      response 500, 'Internal server error' do
        document_response_without_test!
      end
    end
  end

  path '/person_certcourses' do
    post '' do
      security [Bearer: []]
      let(:Authorization) { '' }
      tags 'Courseware'

      parameter name: :"person_certcourse[certcourse_id]", in: :formData, type: :string
      parameter name: :page_id, in: :formData, type: :string
      parameter name: :answer_id, in: :formData, type: :string

      let(:quiz_page) { create(:quiz_page) }
      let(:answer_id) { quiz_page.answers.first.id }
      let(:page_id) { quiz_page.certcourse_page.id }
      let(:person_certcourse) { create(:person_certcourse, certcourse: quiz_page.certcourse_page.certcourse) }
      let('person_certcourse[certcourse_id]') { quiz_page.certcourse_page.certcourse.id }

      produces 'application/vnd.api.v4+json'
      consumes 'multipart/form-data'

      response '200', 'HTTP/1.1 200 Ok' do
        let(:Authorization) { "Bearer #{::TokenProvider.issue_token(user_id: person_certcourse.person.id)}" }
        #
        schema "$ref": '#/definitions/PersonCertcourseCreateJson'
        run_test!
      end
      response '401', '' do
        run_test!
      end
      response '422', '' do
        document_response_without_test!
      end
      response '404', '' do
        let(:Authorization) { "Bearer #{::TokenProvider.issue_token(user_id: person_certcourse.person.id)}" }
        let(:page_id) { Time.zone.now.to_i }
        run_test!
      end
      response 500, 'Internal server error' do
        document_response_without_test!
      end
    end
  end
end
