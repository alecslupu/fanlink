require "swagger_helper"

RSpec.describe "Api::V4::Trivia::GameLeaderboardsController", type: :request, swagger_doc: "v4/swagger.json" do
  #path "/trivia/games/{game_id}/rounds/{round_id}/leaderboard/me" do
  #  get "displays my possition leaderboard" do
  #    tags "Trivia"
  #    security [Bearer: []]
  #    produces "application/vnd.api.v4+json"
  #    parameter name: :game_id, in: :path, schema: {type: :integer}
  #    parameter name: :round_id, in: :path, schema: {type: :integer}
  #    parameter name: "X-App", in: :header, schema: {type: :string}
  #    parameter name: "X-Current-Product", in: :header, schema: {type: :string}
  #    response "200", "displays completed games" do
  #      let(:user) { create(:person) }
  #      let(:Authorization) { "Bearer #{::TokenProvider.issue_token(user_id: user.id)}" }
  #      let!(:games) {
  #        ActsAsTenant.with_tenant(user.product) {
  #          create_list(:full_trivia_game, 10, with_leaderboard: true)
  #        }
  #      }
  #      schema "$ref": "#/definitions/trivia_rounds_leaderboard"
  #
  #      run_test!
  #    end
  #
  #    response "401", "unauthorized" do
  #      let(:user) { create(:person, terminated: true) }
  #      let(:Authorization) { "Bearer #{::TokenProvider.issue_token(user_id: user.id)}" }
  #      let!(:games) {
  #        ActsAsTenant.with_tenant(user.product) {
  #          create_list(:full_trivia_game, 10, with_leaderboard: true)
  #        }
  #      }
  #      run_test!
  #    end
  #  end
  #end
  #path "/trivia/games/{game_id}/rounds/{round_id}/leaderboard" do
  #  get "displays complete leaderboard" do
  #    tags "Trivia"
  #    security [Bearer: []]
  #    produces "application/vnd.api.v4+json"
  #    parameter name: "X-Per-Page", in: :header, schema: {type: :integer}
  #    parameter name: "X-Page", in: :header,schema: {type: :integer}
  #    parameter name: :game_id, in: :path, schema: {type: :integer}
  #    parameter name: :round_id, in: :path, schema: {type: :integer}
  #    parameter name: "X-App", in: :header, schema: {type: :string}
  #    parameter name: "X-Current-Product", in: :header, schema: {type: :string}
  #    response "200", "displays completed games" do
  #      let(:user) { create(:person) }
  #      let(:Authorization) { "Bearer #{::TokenProvider.issue_token(user_id: user.id)}" }
  #      let!(:games) {
  #        ActsAsTenant.with_tenant(user.product) {
  #          create_list(:full_trivia_game, 10, with_leaderboard: true)
  #        }
  #      }
  #      schema "$ref": "#/definitions/trivia_rounds_leaderboard_list"
  #      run_test!
  #    end
  #
  #    response "401", "unauthorized" do
  #      let(:user) { create(:person, terminated: true) }
  #      let(:Authorization) { "Bearer #{::TokenProvider.issue_token(user_id: user.id)}" }
  #      let!(:games) {
  #        ActsAsTenant.with_tenant(user.product) {
  #          create_list(:full_trivia_game, 10, with_leaderboard: true)
  #        }
  #      }
  #      run_test!
  #    end
  #  end
  #end
end
