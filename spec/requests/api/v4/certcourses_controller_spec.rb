require "swagger_helper"

RSpec.describe "Api::V4::CertcoursesController", type: :request, swagger_doc: "v4/swagger.json" do

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
      response "200", "" do
        let(:Authorization) { "Bearer #{::TokenProvider.issue_token(user_id: person_certcourse.person.id)}" }
        schema "$ref": "#/definitions/faulty"
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
