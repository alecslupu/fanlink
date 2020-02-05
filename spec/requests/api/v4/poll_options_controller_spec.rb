require "swagger_helper"

RSpec.describe "Api::V4::PollOptionsController", type: :request, swagger_doc: "v4/swagger.json" do

  path "/posts/{id}/polls/{poll_id}/poll_options/{poll_option_id}/cast_vote" do
    post "" do
      security [Bearer: []]
      tags "Posts"

      parameter name: :id, in: :path, type: :string
      parameter name: :poll_option_id, in: :path, type: :string
      parameter name: :poll_id, in: :path, type: :string

      let(:Authorization) { "" }
      let(:person) { create(:person) }
      let(:id) { create(:post, person: person).id }
      let(:poll) { create(:poll, poll_type_id: id) }
      let(:poll_id) { poll.id }
      let(:poll_option_id) { create(:poll_option, poll: poll).id }

      produces "application/vnd.api.v4+json"
      consumes "multipart/form-data"
      response "200", "HTTP/1.1 200 Ok" do
        let(:Authorization) { "Bearer #{::TokenProvider.issue_token(user_id: person.id)}" }
        schema "$ref": "#/definitions/PollOptionObject"

        run_test!
      end
      response "401", "" do
        run_test!
      end
      #response "404", "" do
      #  let(:Authorization) { "Bearer #{::TokenProvider.issue_token(user_id: person.id)}" }
      #  let(:id) { Time.zone.now.to_i }
      #
      #  run_test!
      #end
      response 500, "Internal server error" do
        document_response_without_test!
      end
    end
  end
end
