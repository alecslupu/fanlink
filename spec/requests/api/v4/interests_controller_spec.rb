require "swagger_helper"

RSpec.describe "Api::V4::InterestsController", type: :request, swagger_doc: "v4/swagger.json" do

  path "/interests/match" do
    get "" do
      security [Bearer: []]

      tags "Interests"

      parameter name: :interest_ids, type: :string, in: :query, required: false

      produces "application/vnd.api.v4+json"
      consumes "multipart/form-data"

      let(:Authorization) { "" }
      let(:person) { create(:person) }
      let(:id) { create(:interest).id }

      let(:interest_list) { create_list(:interest, 4) }

      response "200", "" do
        let(:Authorization) { "Bearer #{::TokenProvider.issue_token(user_id: person.id)}" }
        let(:interest_ids) { interest_list.collect(&:id).join(",") }
        schema "$ref": "#/definitions/faulty"

        run_test!
      end
      response "401", "" do
        run_test!
      end
      response "422", "" do
        let(:Authorization) { "Bearer #{::TokenProvider.issue_token(user_id: person.id)}" }
        let(:interest_ids) { interest_list.first.id }
        run_test!
      end
      response "404", "" do
        let(:Authorization) { "Bearer #{::TokenProvider.issue_token(user_id: person.id)}" }
        run_test!
      end
      response 500, "Internal server error" do
        document_response_without_test!
      end
    end
  end
  path "/interests/{id}/add" do
    post "" do
      security [Bearer: []]
      tags "Interests"

      parameter name: :id, in: :path, type: :string
      parameter name: :"interest[title]", in: :formData, type: :string
      parameter name: :"interest[parent_id]", in: :formData, type: :integer
      parameter name: :"interest[order]", in: :formData, type: :integer

      let(:id) { create(:interest).id }
      let("interest[title]") { "Fake" }
      let("interest[parent_id]") { id }
      let("interest[order]") { 2 }

      produces "application/vnd.api.v4+json"
      consumes "multipart/form-data"

      let(:Authorization) { "" }
      let(:person) { create(:person) }

      response "200", "" do
        let(:Authorization) { "Bearer #{::TokenProvider.issue_token(user_id: person.id)}" }
        run_test!
      end
      response "401", "" do
        run_test!
      end
      response "404", "" do
        let(:id) { Time.zone.now.to_i }

        let(:Authorization) { "Bearer #{::TokenProvider.issue_token(user_id: person.id)}" }
        run_test!
      end
      response 500, "Internal server error" do
        document_response_without_test!
      end
    end
  end
  path "/interests/{id}/remove" do
    post "" do
      security [Bearer: []]
      tags "Interests"

      produces "application/vnd.api.v4+json"
      consumes "multipart/form-data"

      parameter name: :id, in: :path, type: :string

      let(:id) { create(:interest).id }

      let(:Authorization) { "" }
      let(:person) { create(:person) }

      response "200", "" do
        let(:Authorization) { "Bearer #{::TokenProvider.issue_token(user_id: person.id)}" }
        run_test!
      end
      response "401", "" do
        run_test!
      end
      response "404", "" do
        let(:Authorization) { "Bearer #{::TokenProvider.issue_token(user_id: person.id)}" }
        let(:id) { Time.zone.now.to_i }

        run_test!
      end
      response 500, "Internal server error" do
        document_response_without_test!
      end
    end
  end
  path "/interests" do
    get "" do
      security [Bearer: []]
      tags "Interests"

      produces "application/vnd.api.v4+json"
      consumes "multipart/form-data"

      let(:Authorization) { "" }
      let(:person) { create(:person) }

      response "200", "" do
        let(:Authorization) { "Bearer #{::TokenProvider.issue_token(user_id: person.id)}" }
        schema "$ref": "#/definitions/faulty"

        run_test!
      end
      response "401", "" do
        run_test!
      end
      response 500, "Internal server error" do
        document_response_without_test!
      end
    end
  end
end
