require "swagger_helper"

RSpec.describe "Api::V4::Trivia::GamesControllers", type: :request, swagger_doc: "v4/swagger.json" do


  path "/trivia/games/completed" do

    get "displays completed games" do
      tags "Trivia"
      security [Bearer: []]
      produces "application/vnd.api.v4+json"
      response "200", "displays completed games" do
        let(:user) { create(:person) }
        let(:Authorization) { "Bearer #{::TokenProvider.issue_token( user_id: user.id ) }" }
        let!(:games) { ActsAsTenant.with_tenant(user.product) {
          create_list(:trivia_game, 10, status: :published, end_date: DateTime.now.to_i - 100)
        }}
        schema ref: "#/definitions/trivia_games_list"
        run_test! do |response|
          expect(response.body).to eq("")
        end
      end
      response "401", "unauthorized" do
        let(:user) { create(:person, terminated: true) }
        let(:Authorization) { "Bearer #{::TokenProvider.issue_token( user_id: user.id ) }" }
        let!(:games) { ActsAsTenant.with_tenant(user.product) {
          create_list(:trivia_game, 10, status: :published, end_date: DateTime.now.to_i - 100)
        }}
        run_test! do |response|
          expect(response.body).to eq("")
        end

      end
    end
  end


  path "/trivia/games" do
    get "displays future and on going games" do
      tags "Trivia"
      security [Bearer: []]
      produces "application/vnd.api.v4+json"
      response "200", "displays future and on going games" do
        schema ref: "#/definitions/trivia_games_list"
        let(:user) { create(:person) }
        let(:Authorization) { "Bearer #{::TokenProvider.issue_token( user_id: user.id ) }" }
        let!(:games) { ActsAsTenant.with_tenant(user.product) {
          create_list(:trivia_game, 10, status: :published, end_date: DateTime.now.to_i + 100)
        }}
        run_test! do |response|
          expect(response.body).to eq("")
        end
      end

      response "401", "unauthorized" do
        let(:user) { create(:person, terminated: true ) }
        let(:Authorization) { "Bearer #{::TokenProvider.issue_token( user_id: user.id ) }" }
        let!(:games) { ActsAsTenant.with_tenant(user.product) {
          create_list(:trivia_game, 10, status: :published, end_date: DateTime.now.to_i - 100)
        }}
        run_test! do |response|
          expect(response.body).to eq("")
        end
      end
    end
  end
end
