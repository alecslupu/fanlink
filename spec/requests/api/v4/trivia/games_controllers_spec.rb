require "swagger_helper"

RSpec.describe "Api::V4::Trivia::GamesControllers", type: :request, swagger_doc: "v4/swagger.json" do
  path "/trivia/games/completed" do
    let(:user) { create(:person) }
    let(:Authorization) { "Bearer #{::TokenProvider.issue_token( user_id: user.id ) }" }
    let!(:games) { ActsAsTenant.with_tenant(user.product) {
      create_list(:trivia_game, 10, status: :published, end_date: DateTime.now.to_i - 100)
    }}

    get "displays completed games" do
      tags "Trivia"
      security [Bearer: []]
      produces "application/vnd.api.v4+json"
      response "200", "displays completed games" do
        schema type: :object,
               properties: {
                 games: {
                   type: :array,
                   items: {
                     "$ref" => "#/definitions/trivia_game"
                   }
                 }
               },
               required: ["games"]

        run_test!
      end
      response "401", "unauthorized" do
        let(:user) { create(:person, terminated: true ) }
        let(:Authorization) { "Bearer #{::TokenProvider.issue_token( user_id: user.id ) }" }
        run_test!

      end
    end
  end

  path "/trivia/games" do
    # let(:user) { create(:person, username: 'AlecsLupu') }
    # let(:Authorization) { "Bearer #{::TokenProvider.issue_token( user_id: user.id ) }" }
    # # let!(:games) { ActsAsTenant.with_tenant(cuser.product) {
    # #   create_list(:trivia_game, 10, status: :published, end_date: DateTime.now.to_i + 100)
    # # }}

    get "displays future and on going games" do
      tags "Trivia"
      security [Bearer: []]
      produces "application/vnd.api.v4+json"
      response "200", "displays future and on going games" do
        schema type: :object,
               properties: {
                 games: {
                   type: :array,
                   items: {
                     "$ref" => "#/definitions/trivia_game"
                   }
                 }
               },
               required: ["games"]
        run_test!
      end

      response "401", "unauthorized" do
        let(:user) { create(:person, terminated: true ) }
        let(:Authorization) { "Bearer #{::TokenProvider.issue_token( user_id: user.id ) }" }
        run_test!
      end
    end
  end
end

