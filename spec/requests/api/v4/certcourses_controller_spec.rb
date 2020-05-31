# frozen_string_literal: true
require "swagger_helper"


RSpec.describe "Api::V4::CertcoursesController", type: :request, swagger_doc: "v4/swagger.json" do

  path "/certificates/{certificate_id}/certcourses" do
    get "" do
      security [Bearer: []]
      let(:Authorization) { "" }
      parameter name: :certificate_id, in: :path, type: :string
      tags "Courseware"

      let(:certificate_certcourse) { create(:certificate_certcourse) }
      let(:certificate_id) { certificate_certcourse.certificate_id }
      let(:person) { create(:person) }

      produces "application/vnd.api.v4+json"

      response "200", "HTTP/1.1 200 Ok" do
        let(:Authorization) { "Bearer #{::TokenProvider.issue_token(user_id: person.id)}" }
        schema "$ref": "#/definitions/CertcourseArray"

        run_test!
      end
      response "401", "" do
        run_test!
      end
      response "404", "" do
        let(:certificate_id) { Time.zone.now.to_i }
        let(:Authorization) { "Bearer #{::TokenProvider.issue_token(user_id: person.id)}" }
        let(:certificate_id) { Time.now.to_i}
        run_test!
      end
      response 500, "Internal server error" do
        document_response_without_test!
      end
      #    tags ["education", 'kotlin']
    end
  end

  path "/certcourses/{id}" do
    get "" do
      security [Bearer: []]
      let(:Authorization) { "" }
      let(:person_certcourse) { create(:person_certcourse) }
      let(:id) { person_certcourse.certcourse.id }

      tags "Courseware"
      parameter name: :id, in: :path, type: :string, required: false

      produces "application/vnd.api.v4+json"
      consumes "multipart/form-data"

      response "200", "HTTP/1.1 200 Ok" do
        let(:Authorization) { "Bearer #{::TokenProvider.issue_token(user_id: person_certcourse.person.id)}" }

        let!(:image_page) {
          ActsAsTenant.with_tenant(person_certcourse.person.product) {
            create(:image_page, certcourse_page: create(:certcourse_page, certcourse: person_certcourse.certcourse ) )
          }
        }
        let!(:video_page) {
          ActsAsTenant.with_tenant(person_certcourse.person.product) {

            allow_any_instance_of(VideoPage).to receive(:video_duration).and_return(31)
            create(:video_page, certcourse_page: create(:certcourse_page, certcourse: person_certcourse.certcourse ) )
          }
        }
        let!(:download_file_page) {
          ActsAsTenant.with_tenant(person_certcourse.person.product) {
            create(:download_file_page, certcourse_page: create(:certcourse_page, certcourse: person_certcourse.certcourse ) )
          }
        }

        schema "$ref": "#/definitions/CertcoursePageArray"
        run_test!
      end
      response "401", "" do
        run_test!
      end
      response "404", "" do
        let(:Authorization) { "Bearer #{::TokenProvider.issue_token(user_id: person_certcourse.person.id)}" }
        let(:id) { Time.zone.now.to_i }

        run_test!
      end
      response 500, "Internal server error" do
        document_response_without_test!
      end
    end
  end
end
